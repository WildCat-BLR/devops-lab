locals {
  tags = {
    environment = "lab"
    managed_by  = "terraform"
    project     = "devops-kforge-lab"
  }
}

resource "azurerm_resource_group" "lab" {
  name     = var.resource_group_name
  location = "eastus"
  tags     = local.tags
}

module "aks" {
  source = "./modules/AKS"

  cluster_name        = var.cluster_name
  location            = azurerm_resource_group.lab.location
  resource_group_name = azurerm_resource_group.lab.name
  tags                = local.tags

  authorized_ip_ranges = var.authorized_ip_ranges
}

moved {
  from = azurerm_kubernetes_cluster.lab
  to   = module.aks.azurerm_kubernetes_cluster.lab
}

data "azurerm_container_registry" "persistent" {
  name                = var.acr_name
  resource_group_name = var.acr_resource_group_name
}

resource "azurerm_role_assignment" "aks_acr_pull" {
  scope                = data.azurerm_container_registry.persistent.id
  role_definition_name = "Container Registry Repository Reader"
  principal_id         = module.aks.kubelet_identity_object_id
  principal_type       = "ServicePrincipal"
}