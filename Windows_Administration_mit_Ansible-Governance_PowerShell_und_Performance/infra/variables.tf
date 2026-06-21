variable "subscription_id" {
  description = "Azure Subscription ID (az account show --query id -o tsv)"
  type        = string
}

variable "location" {
  description = "Azure-Region – germanywestcentral (Frankfurt) ist für DE am günstigsten"
  type        = string
  default     = "germanywestcentral"
}

variable "admin_username" {
  description = "Admin-Benutzername für die Windows VM"
  type        = string
  default     = "ansible"
}

variable "admin_password" {
  description = "Admin-Passwort (mind. 12 Zeichen, Groß+Klein+Zahl+Sonderzeichen)"
  type        = string
  sensitive   = true
}

variable "vm_size" {
  description = "VM-Größe: Standard_B2s = 2 vCPU / 4 GB ~€0.04/h, Standard_B2ms = 2 vCPU / 8 GB ~€0.08/h"
  type        = string
  default     = "Standard_B2s"
}

variable "auto_shutdown_time" {
  description = "Tägliche Auto-Abschaltzeit (UTC, Format HHMM) – schützt vor vergessenen laufenden VMs"
  type        = string
  default     = "2100"
}

variable "ssh_public_key" {
  description = "Öffentlicher SSH-Key für AWX-Node (cat ~/.ssh/id_ed25519.pub)"
  type        = string
}

variable "awx_vm_size" {
  description = "AWX VM-Größe: Standard_B4ms = 4 vCPU / 16 GB ~€0.15/h – Minimum für k3s + AWX"
  type        = string
  default     = "Standard_B4ms"
}
