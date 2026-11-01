output "cluster_name" {
  description = "AKS cluster name."
  value       = azurerm_kubernetes_cluster.lab.name
}

output "cluster_id" {
  description = "AKS resource ID."
  value       = azurerm_kubernetes_cluster.lab.id
}

output "node_resource_group" {
  description = "AKS-managed group containing nodes, disks and networking."
  value       = azurerm_kubernetes_cluster.lab.node_resource_group
}

output "private_fqdn" {
  description = "Kubernetes API hostname, accessible only through private networking."
  value       = azurerm_kubernetes_cluster.lab.private_fqdn
}
