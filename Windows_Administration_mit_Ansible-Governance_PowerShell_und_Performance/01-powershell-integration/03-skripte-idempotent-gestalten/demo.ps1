$Path = "C:\Windows\Temp\ansible-idempotent-demo.txt"
$Desired = "managed by ansible"
$Current = if (Test-Path $Path) { Get-Content -Path $Path -Raw } else { "" }
if ($Current.Trim() -ne $Desired) {
    Set-Content -Path $Path -Value $Desired -Encoding UTF8
    "Changed=True"
} else {
    "Changed=False"
}
