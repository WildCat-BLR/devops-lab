resource "azurerm_kubernetes_cluster" "lab" {
  name                = var.cluster_name
  location            = var.location
  resource_group_name = var.resource_group_name
  dns_prefix          = var.cluster_name
  sku_tier            = "Free"

  private_cluster_enabled             = false
  private_cluster_public_fqdn_enabled = false
  private_dns_zone_id                 = "System"
  role_based_access_control_enabled   = true

  default_node_pool {
    name                         = "system"
    vm_size                      = "Standard_B2s"
    node_count                   = 1
    auto_scaling_enabled         = false
    only_critical_addons_enabled = false
    node_public_ip_enabled       = false
    os_sku                       = "Ubuntu"
    os_disk_type                 = "Managed"
    os_disk_size_gb              = 32
    max_pods                     = 30
    tags                         = var.tags
  }

  node_provisioning_profile {
    default_node_pools = "Auto"
  }

  api_server_access_profile {
    authorized_ip_ranges = var.authorized_ip_ranges
  }

  identity {
    type = "SystemAssigned"
  }

  network_profile {
    network_plugin      = "azure"
    network_plugin_mode = "overlay"
    network_policy      = "azure"
    load_balancer_sku   = "standard"
    outbound_type       = "loadBalancer"

    load_balancer_profile {
      managed_outbound_ip_count = 1
    }
  }

  storage_profile {
    blob_driver_enabled         = false
    disk_driver_enabled         = false
    file_driver_enabled         = false
    snapshot_controller_enabled = false
  }

  tags = var.tags
}