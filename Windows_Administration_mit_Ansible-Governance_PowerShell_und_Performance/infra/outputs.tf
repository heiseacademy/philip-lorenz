output "windows_target_ip" {
  description = "Öffentliche IP des Windows Targets"
  value       = azurerm_public_ip.windows.ip_address
}

output "awx_ip" {
  description = "Öffentliche IP des AWX Nodes"
  value       = azurerm_public_ip.awx.ip_address
}

output "rdp_windows" {
  description = "RDP-Verbindung"
  value       = "${azurerm_public_ip.windows.ip_address}:3389"
}

output "awx_url" {
  description = "AWX Web UI (erst ~15 min nach Start bereit)"
  value       = "http://${azurerm_public_ip.awx.ip_address}:30080"
}

output "awx_password_cmd" {
  description = "AWX Admin-Passwort abrufen"
  value       = "ssh azureuser@${azurerm_public_ip.awx.ip_address} 'cat /root/AWX_ADMIN_PASSWORD'"
}

output "awx_setup_log" {
  description = "AWX Setup-Fortschritt verfolgen"
  value       = "ssh azureuser@${azurerm_public_ip.awx.ip_address} 'tail -f /root/awx-setup.log'"
}

output "ansible_inventory" {
  description = "Werte für inventory.ini"
  value       = <<-EOT
    ansible_host=${azurerm_public_ip.windows.ip_address}
    ansible_user=${var.admin_username}
    ansible_winrm_transport=ntlm
    ansible_winrm_server_cert_validation=ignore
    ansible_winrm_port=5985
    ansible_winrm_scheme=http
  EOT
}

output "vm_starten" {
  value = <<-EOT
    az vm start -g ansible-kurs-rg -n windows-target
    az vm start -g ansible-kurs-rg -n awx-node
  EOT
}

output "vm_stoppen" {
  value = <<-EOT
    az vm deallocate -g ansible-kurs-rg -n windows-target
    az vm deallocate -g ansible-kurs-rg -n awx-node
  EOT
}
