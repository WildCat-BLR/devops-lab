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