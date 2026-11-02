terraform {
  required_version = ">= 1.7.0, < 2.0.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 5.0"
    }
  }

  backend "azurerm" {
    use_oidc             = true                                   # Can also be set via `ARM_USE_OIDC` environment variable.
    use_azuread_auth     = true                                   # Can also be set via `ARM_USE_AZUREAD` environment variable.
    tenant_id            = "b41b72d0-4e9f-4c26-8a69-f949f367c91d" # Can also be set via `ARM_TENANT_ID` environment variable.
    client_id            = "26e4789f-2036-4051-b599-e04aaa6d4cc2" # Can also be set via `ARM_CLIENT_ID` environment variable.
    storage_account_name = "terraformsa1999"                      # Can be passed via `-backend-config=`"storage_account_name=<storage account name>"` in the `init` command.
    container_name       = "tfstate"                              # Can be passed via `-backend-config=`"container_name=<container name>"` in the `init` command.
    key                  = "lab1.terraform.tfstate"               # Can be passed via `-backend-config=`"key=<blob key name>"` in the `init` command.
  }
}