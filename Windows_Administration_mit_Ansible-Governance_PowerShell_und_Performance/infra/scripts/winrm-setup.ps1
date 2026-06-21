# winrm-setup.ps1
# Als Administrator auf dem Windows-Target ausführen – direkt nach der Installation.
# Aktiviert WinRM mit NTLM-Auth und legt den ansible-Benutzer an.
#
# Ausführen:
#   PowerShell -ExecutionPolicy Bypass -File winrm-setup.ps1

#Requires -RunAsAdministrator
Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

Write-Host "=== WinRM-Setup für Ansible ===" -ForegroundColor Cyan

# ── Passwort einlesen ─────────────────────────────────────────────────────────
$Password = Read-Host "Passwort für ansible-Benutzer" -AsSecureString

# ── WinRM aktivieren ──────────────────────────────────────────────────────────
Write-Host "Aktiviere WinRM..."
Enable-PSRemoting -Force -SkipNetworkProfileCheck

# ── Authentifizierung konfigurieren ──────────────────────────────────────────
Write-Host "Konfiguriere NTLM-Auth..."
Set-Item -Path WSMan:\localhost\Service\Auth\Basic   -Value $true
Set-Item -Path WSMan:\localhost\Service\Auth\NTLM    -Value $true
Set-Item -Path WSMan:\localhost\Service\AllowUnencrypted -Value $true
Set-Item -Path WSMan:\localhost\Client\AllowUnencrypted  -Value $true

# ── HTTP-Listener sicherstellen (Port 5985) ───────────────────────────────────
Write-Host "Richte WinRM HTTP-Listener ein..."
$existingListener = Get-WSManInstance -ResourceURI winrm/config/Listener `
    -SelectorSet @{Address="*"; Transport="HTTP"} -ErrorAction SilentlyContinue

if (-not $existingListener) {
    New-WSManInstance -ResourceURI winrm/config/Listener `
        -SelectorSet @{Address="*"; Transport="HTTP"} `
        -ValueSet @{Enabled="true"} | Out-Null
}

# ── Lokalen Ansible-Benutzer anlegen ─────────────────────────────────────────
Write-Host "Lege ansible-Benutzer an..."
$user = Get-LocalUser -Name "ansible" -ErrorAction SilentlyContinue
if (-not $user) {
    New-LocalUser -Name "ansible" -Password $Password `
        -FullName "Ansible Service Account" `
        -PasswordNeverExpires -UserMayNotChangePassword | Out-Null
}
else {
    Set-LocalUser -Name "ansible" -Password $Password | Out-Null
    Write-Host "  Benutzer existiert bereits – Passwort aktualisiert."
}

Add-LocalGroupMember -Group "Administrators" -Member "ansible" -ErrorAction SilentlyContinue

# ── Windows-Firewall-Regeln ───────────────────────────────────────────────────
Write-Host "Öffne Firewall für WinRM..."
$rules = @(
    @{Name="WinRM HTTP";  Port=5985},
    @{Name="WinRM HTTPS"; Port=5986}
)
foreach ($r in $rules) {
    $existing = Get-NetFirewallRule -DisplayName $r.Name -ErrorAction SilentlyContinue
    if (-not $existing) {
        New-NetFirewallRule -DisplayName $r.Name -Direction Inbound `
            -Protocol TCP -LocalPort $r.Port -Action Allow | Out-Null
    }
}

# ── WinRM-Service neu starten ─────────────────────────────────────────────────
Restart-Service WinRM

# ── Prüfung ───────────────────────────────────────────────────────────────────
Write-Host ""
Write-Host "=== Aktive WinRM-Listener ===" -ForegroundColor Green
Get-WSManInstance -ResourceURI winrm/config/Listener -Enumerate | `
    Format-Table Address, Transport, Port, Enabled -AutoSize

Write-Host ""
Write-Host "=== Setup abgeschlossen ===" -ForegroundColor Green
Write-Host "Inventory-Einstellungen:"
Write-Host "  ansible_host=$($(Get-NetIPAddress -AddressFamily IPv4 | Where-Object {$_.InterfaceAlias -notlike '*Loopback*'} | Select-Object -First 1).IPAddress)"
Write-Host "  ansible_user=ansible"
Write-Host "  ansible_winrm_transport=ntlm"
Write-Host "  ansible_winrm_port=5985"
