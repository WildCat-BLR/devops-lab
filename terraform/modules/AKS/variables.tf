variable "cluster_name" {
  description = "Name and DNS prefix of the private AKS cluster."
  type        = string
}

variable "resource_group_name" {
  description = "Existing resource group in which to create AKS."
  type        = string
}

variable "location" {
  description = "Azure region of the resource group."
  type        = string
}

variable "tags" {
  description = "Tags applied to the cluster and its system node pool."
  type        = map(string)
  default     = {}
}

variable "authorized_ip_ranges" {
  description = "List of authorized IP ranges for the API server."
  type        = list(string)
  default     = []
}