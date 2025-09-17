variable "location" {
  description = "Azure region"
  type        = string
  default     = "UK West"
}

variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "virtual_network_name" {
  description = "Name of the virtual network"
  type        = string
}

variable "address_space" {
  description = "Address space for the virtual network"
  type        = list(string)
}

variable "subnet_name" {
  description = "Name of the subnet"
  type        = string
}

variable "subnet_prefix" {
  description = "Address prefix for the subnet"
  type        = string
}

variable "nsg_name" {
  description = "Name of the network security group"
  type        = string
}

variable "nsg_rules" {
  description = "List of security rules for the NSG"
  type = list(object({
    name                       = string
    priority                   = number
    direction                  = string
    access                     = string
    protocol                   = string
    source_port_range          = string
    destination_port_range     = string
    source_address_prefix      = string
    destination_address_prefix = string
  }))
}

variable "public_ip_name" {
  description = "Name of the public IP"
  type        = string
}

variable "public_ip_allocation" {
  description = "Allocation method for the public IP (Static/Dynamic)"
  type        = string
}

variable "nic_name" {
  description = "Name of the network interface"
  type        = string
}

variable "enable_accelerated_networking" {
  description = "Enable accelerated networking on NIC"
  type        = bool
  default     = false
}

variable "vm_name" {
  description = "Name of the virtual machine"
  type        = string
}

variable "vm_computer_name" {
  description = "Computer name of the VM"
  type        = string
}

variable "vm_size" {
  description = "Size of the virtual machine"
  type        = string
}

variable "admin_username" {
  description = "Admin username for the VM"
  type        = string
}

variable "os_disk_type" {
  description = "Storage type for OS disk"
  type        = string
}

variable "data_disks" {
  description = "Data disks to attach to the VM"
  type = list(object({
    name                 = string
    lun                  = number
    storage_account_type = string
    disk_size_gb         = number
    caching              = string
  }))
}

# Variables for backend and secrets
variable "storage_account_name" {
  description = "The Azure Storage Account for Terraform backend"
  type        = string
}

variable "ssh_public_key" {
  description = "The public SSH key used for VM login"
  type        = string
}

# Optional variables if you want to also pass ARM credentials via tfvars
variable "subscription_id" {
  description = "Azure Subscription ID"
  type        = string
  default     = ""
}

variable "tenant_id" {
  description = "Azure Tenant ID"
  type        = string
  default     = ""
}

variable "client_id" {
  description = "Azure Service Principal Client ID"
  type        = string
  default     = ""
}

variable "client_secret" {
  description = "Azure Service Principal Client Secret"
  type        = string
  sensitive   = true
  default     = ""
}
