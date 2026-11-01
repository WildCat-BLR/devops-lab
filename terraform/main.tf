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
}

moved {
  from = azurerm_kubernetes_cluster.lab
  to   = module.aks.azurerm_kubernetes_cluster.lab
}