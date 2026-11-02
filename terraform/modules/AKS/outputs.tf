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

output "authorized_ip_ranges" {
  description = "List of authorized IP ranges for the API server."
  value       = azurerm_kubernetes_cluster.lab.api_server_access_profile[0].authorized_ip_ranges
}

output "kubelet_identity_object_id" {
  description = "Object ID of the kubelet identity used for image pulls."
  value       = azurerm_kubernetes_cluster.lab.kubelet_identity[0].object_id
}