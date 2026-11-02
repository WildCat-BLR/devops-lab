output "resource_group_name" {
  description = "Dedicated lab resource group."
  value       = azurerm_resource_group.lab.name
}

output "cluster_name" {
  description = "AKS cluster name."
  value       = module.aks.cluster_name
}

output "cluster_id" {
  description = "AKS resource ID."
  value       = module.aks.cluster_id
}

output "node_resource_group" {
  description = "AKS-managed group containing nodes, disks and networking."
  value       = module.aks.node_resource_group
}

output "private_fqdn" {
  description = "Kubernetes API hostname, accessible only through private networking."
  value       = module.aks.private_fqdn
}