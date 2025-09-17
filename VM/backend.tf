terraform {
  backend "azurerm" {
    resource_group_name  = "devsecops-cloud_group"
    storage_account_name = "devsecopscloudtfstate"
    container_name       = "tfstate"
    key                  = "terraform.tfstate"
  }
}