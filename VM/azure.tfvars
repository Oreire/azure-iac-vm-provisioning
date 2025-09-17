# Resource Group and Network
resource_group_name  = "devsecops-cloud_group"
virtual_network_name = "devsecops-cloud_group-vnet"
address_space        = ["10.0.0.0/16"]

subnet_name   = "default"
subnet_prefix = "10.0.0.0/24"

# Network Security Group
nsg_name = "devsecops-cloud-nsg"

nsg_rules = [
  {
    name                       = "allow-ssh"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  },
  {
    name                       = "allow-http"
    priority                   = 200
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  },
  {
    name                       = "allow-https"
    priority                   = 210
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "443"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
]

# Public IP and NIC
public_ip_name       = "devsecops-cloud-ip"
public_ip_allocation = "Static"

nic_name                      = "devsecops-cloud801"
enable_accelerated_networking = true

# Virtual Machine
vm_name          = "devsecops-cloud"
vm_computer_name = "devsecops-cloud"
vm_size          = "Standard_D4s_v3"
admin_username   = "devsecops"
os_disk_type     = "StandardSSD_LRS"

# Data Disks
data_disks = [
  {
    name                 = "devsecops-cloud_DataDisk_0"
    lun                  = 0
    storage_account_type = "StandardSSD_LRS"
    disk_size_gb         = 512
    caching              = "ReadOnly"
  }
]

# Location
location = "UK South"

# Storage account for Terraform backend (not used by VM)
# Optional: keep here for reference
storage_account_name = "devsecopscloudtfstate"
