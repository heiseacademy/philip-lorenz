# ── Windows Target ──────────────────────────────────────────────────────────

resource "azurerm_public_ip" "windows" {
  name                = "windows-target-pip"
  location            = azurerm_resource_group.lab.location
  resource_group_name = azurerm_resource_group.lab.name
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_network_interface" "windows" {
  name                = "windows-target-nic"
  location            = azurerm_resource_group.lab.location
  resource_group_name = azurerm_resource_group.lab.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.lab.id
    private_ip_address_allocation = "Static"
    private_ip_address            = "10.0.1.20"
    public_ip_address_id          = azurerm_public_ip.windows.id
  }
}

resource "azurerm_network_interface_security_group_association" "windows" {
  network_interface_id      = azurerm_network_interface.windows.id
  network_security_group_id = azurerm_network_security_group.windows.id
}

resource "azurerm_windows_virtual_machine" "windows" {
  name                = "windows-target"
  resource_group_name = azurerm_resource_group.lab.name
  location            = azurerm_resource_group.lab.location
  size                = var.vm_size
  admin_username      = var.admin_username
  admin_password      = var.admin_password

  network_interface_ids = [azurerm_network_interface.windows.id]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2022-Datacenter"
    version   = "latest"
  }

  winrm_listener {
    protocol = "Http"
  }
}

resource "azurerm_dev_test_global_vm_shutdown_schedule" "windows" {
  virtual_machine_id    = azurerm_windows_virtual_machine.windows.id
  location              = azurerm_resource_group.lab.location
  enabled               = true
  daily_recurrence_time = var.auto_shutdown_time
  timezone              = "W. Europe Standard Time"

  notification_settings {
    enabled = false
  }
}

# ── AWX Node ────────────────────────────────────────────────────────────────
# Ubuntu 24.04, Standard_B4ms (4 vCPU / 16 GB) – Minimum für k3s + AWX
# cloud-init installiert k3s + AWX Operator automatisch (~15 min nach Start)
# Passwort nach Setup: ssh azureuser@<ip> "cat /root/AWX_ADMIN_PASSWORD"

resource "azurerm_public_ip" "awx" {
  name                = "awx-pip"
  location            = azurerm_resource_group.lab.location
  resource_group_name = azurerm_resource_group.lab.name
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_network_interface" "awx" {
  name                = "awx-nic"
  location            = azurerm_resource_group.lab.location
  resource_group_name = azurerm_resource_group.lab.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.lab.id
    private_ip_address_allocation = "Static"
    private_ip_address            = "10.0.1.30"
    public_ip_address_id          = azurerm_public_ip.awx.id
  }
}

resource "azurerm_network_interface_security_group_association" "awx" {
  network_interface_id      = azurerm_network_interface.awx.id
  network_security_group_id = azurerm_network_security_group.awx.id
}

resource "azurerm_linux_virtual_machine" "awx" {
  name                = "awx-node"
  resource_group_name = azurerm_resource_group.lab.name
  location            = azurerm_resource_group.lab.location
  size                = var.awx_vm_size
  admin_username      = "azureuser"

  network_interface_ids = [azurerm_network_interface.awx.id]

  admin_ssh_key {
    username   = "azureuser"
    public_key = var.ssh_public_key
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
    disk_size_gb         = 30
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "ubuntu-24_04-lts"
    sku       = "server"
    version   = "latest"
  }

  custom_data = base64encode(file("${path.module}/cloud-init/awx-node.yml"))
}

resource "azurerm_dev_test_global_vm_shutdown_schedule" "awx" {
  virtual_machine_id    = azurerm_linux_virtual_machine.awx.id
  location              = azurerm_resource_group.lab.location
  enabled               = true
  daily_recurrence_time = var.auto_shutdown_time
  timezone              = "W. Europe Standard Time"

  notification_settings {
    enabled = false
  }
}
