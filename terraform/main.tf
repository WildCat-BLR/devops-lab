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

resource "azurerm_kubernetes_cluster_extension" "flux" {
  name           = "flux-ext"
  cluster_id     = module.aks.cluster_id
  extension_type = "microsoft.flux"
}

resource "azurerm_kubernetes_flux_configuration" "flux" {
  name       = "flux-fc"
  cluster_id = module.aks.cluster_id
  namespace  = "flux"
  scope      = "cluster"

  git_repository {
    url                      = "https://github.com/WildCat-BLR/devops-lab"
    reference_type           = "branch"
    reference_value          = "main"
    sync_interval_in_seconds = 120
  }

  kustomizations {
    name                       = "lab"
    path                       = "./clusters/lab"
    sync_interval_in_seconds   = 60
    timeout_in_seconds         = 600
    garbage_collection_enabled = true
    wait                       = true

    post_build {
      substitute = {
        INGRESS_PUBLIC_IP_NAME = azurerm_public_ip.ingress.name
        INGRESS_HOSTNAME       = azurerm_public_ip.ingress.fqdn
        ACR_LOGIN_SERVER       = data.azurerm_container_registry.persistent.login_server
      }
    }
  }

  kustomizations {
    name                       = "certificates"
    path                       = "./clusters/lab/certificates"
    depends_on                 = ["lab"]
    sync_interval_in_seconds   = 60
    timeout_in_seconds         = 600
    garbage_collection_enabled = true
    wait                       = true
  }

  kustomizations {
    name                       = "monitoring"
    path                       = "./clusters/lab/monitoring"
    depends_on                 = ["certificates"]
    sync_interval_in_seconds   = 60
    timeout_in_seconds         = 900
    garbage_collection_enabled = true
    wait                       = true

    post_build {
      substitute = {
        INGRESS_HOSTNAME = azurerm_public_ip.ingress.fqdn
      }
    }
  }

  depends_on = [
    azurerm_kubernetes_cluster_extension.flux
  ]
}

resource "azurerm_public_ip" "ingress" {
  name                = "pip-lab-ingress"
  location            = azurerm_resource_group.lab.location
  resource_group_name = module.aks.node_resource_group

  allocation_method = "Static"
  sku               = "Standard"

  domain_name_label = "kforgelab"

  tags = local.tags
}