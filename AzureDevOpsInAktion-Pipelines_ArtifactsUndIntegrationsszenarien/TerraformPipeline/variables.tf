variable "location" {
  description = "Azure Region"
  type        = string
  default     = "West Europe"
}

variable "resource_group_name" {
  description = "Name der Resource Group"
  type        = string
  default     = "myResourceGroupMahlzeitExpress"
}

variable "app_service_plan_name" {
  description = "Name des App Service Plans"
  type        = string
  default     = "myPlanMahlzeitExpress"
}

variable "app_service_name" {
  description = "Name der App Service"
  type        = string
  default = "myPlanMahlzeitExpress"
}
variable "subscription_id" {
  description = "Subscription ID"
  type        = string
  default = ""
}
