variable "subscription_id" {
  description = "Azure subscription ID used for the lab."
  type        = string

  validation {
    condition     = can(regex("^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}$", var.subscription_id))
    error_message = "subscription_id must be an Azure subscription UUID."
  }

  default = "ae4cea4a-dfec-4704-afed-4beb5f48985a"
}

variable "resource_group_name" {
  description = "Dedicated resource group deleted with the lab. Do not use the Terraform state resource group."
  type        = string
  default     = "rg-kforge-lab-01"
}

variable "cluster_name" {
  description = "Name and DNS prefix of the private AKS cluster."
  type        = string
  default     = "aks-kforge-lab-01"
}

variable "authorized_ip_ranges" {
  description = "List of authorized IP ranges for the API server."
  type        = list(string)
  default     = ["0.0.0.0/0"]
}