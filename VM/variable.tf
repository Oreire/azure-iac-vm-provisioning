variable "location" {
  description = "Azure region"
  type        = string
  default     = "UK West"
}

variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
  default     = "vm-rg"
}

variable "virtual_network_name" {
  description = "Name of the virtual network"
  type        = string
  default     = "vm-vnet"
}

variable "address_space" {
  description = "Address space for the virtual network"
  type        = list(string)
  default     = ["10.0.0.0/16"]
}

variable "subnet_name" {
  description = "Name of the subnet"
  type        = string
  default     = "vm-subnet"
}

variable "subnet_prefix" {
  description = "Address prefix for the subnet"
  type        = string
  default     = "10.0.1.0/24"
}

variable "nsg_name" {
  description = "Name of the network security group"
  type        = string
  default     = "vm-nsg"
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
  default = [
    {
      name                       = "SSH"
      priority                   = 1001
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "22"
      source_address_prefix      = "*"
      destination_address_prefix = "*"
    }
  ]
}

variable "public_ip_name" {
  description = "Name of the public IP"
  type        = string
  default     = "vm-pip"
}

variable "public_ip_allocation" {
  description = "Allocation method for the public IP (Static/Dynamic)"
  type        = string
  default     = "Static"
}

variable "nic_name" {
  description = "Name of the network interface"
  type        = string
  default     = "vm-nic"
}

variable "enable_accelerated_networking" {
  description = "Enable accelerated networking on NIC"
  type        = bool
  default     = false
}

variable "vm_name" {
  description = "Name of the virtual machine"
  type        = string
  default     = "vm-instance"
}

variable "vm_computer_name" {
  description = "Computer name of the VM"
  type        = string
  default     = "vm-computer"
}

variable "vm_size" {
  description = "Size of the virtual machine"
  type        = string
  default     = "Standard_B1s"
}

variable "admin_username" {
  description = "Admin username for the VM"
  type        = string
  sensitive   = true
  # ⚠️ No default for security reasons — will come from GitHub secret
}

variable "os_disk_type" {
  description = "Storage type for OS disk"
  type        = string
  default     = "Standard_LRS"
}

variable "data_disks" {
  description = "Data disks to attach to the VM"
  type = list(object({
    name = string
    size = number
  }))
  default = []
}

variable "AZURE_STORAGE_ACCOUNT" {
  description = "The name of the Azure Storage Account for Terraform backend"
  type        = string
  default     = "devsecopscloudtfstate"
}

variable "ssh_public_key" {
  description = "The public SSH key used for VM login"
  type        = string
  sensitive   = true
  # ⚠️ No default for security reasons — will come from GitHub secret
}
