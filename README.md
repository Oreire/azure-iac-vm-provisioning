# IaC-Driven Scalable Azure VM Deployment and Automation with Terraform & GitHub Actions


## Project Overview

This project Streamlined Azure infrastructure deployment with Terraform and GitHub Actions, a fully automated via CI/CD pipelines. It highlighted DevOps best practices, enabling rapid, repeatable, and secure provisioning of VMs, networking, and security resources. The project demonstrates hands-on expertise in DevOps, cloud automation and modern infrastructure management, making it ideal for showcasing practical cloud engineering skills.


## 📌 Features

* Deploys a **resource group** with networking components:

  * Virtual Network (VNet)
  * Subnet
  * Public IP
  * Network Security Group (NSG) with SSH rule
  * Network Interface (NIC)

* Provisions a **Linux VM** with:

  * Custom admin username (from GitHub secret)
  * SSH public key authentication (from GitHub secret)
  * Configurable VM size and OS disk type

* Secure handling of sensitive variables (`admin_username`, `ssh_public_key`)

* Terraform **remote state** stored in an **Azure Storage Account**

* GitHub Actions CI/CD workflow with:

### Trigger Conditions

* Triggers on both **push to `main`** and **manual dispatch**

* **Push to `main`** → Runs full pipeline (`plan` + `apply`)
* **Manual Dispatch (`workflow_dispatch`)**:

  * Select `apply` to provision infrastructure
  * Select `destroy` to tear down infrastructure


## 📂 Repository Structure

.
├── .github/workflows/
│   └── terraform.yml     # GitHub Actions workflow for CI/CD
├── VM/
│   ├── main.tf           # Main Terraform configuration
│   ├── variables.tf      # Input variables (with defaults & sensitive vars)
│   ├── outputs.tf        # Outputs (e.g., Public IP address)
│   └── azure.tfvars      # (Optional) Local variable overrides
└── README.md             # Documentation

## ⚙️ Prerequisites

Before using this repository, ensure you have the following:

1. **Azure Account** with appropriate permissions (Contributor or Owner role).
2. **Service Principal** for GitHub Actions:

   ```bash
   az ad sp create-for-rbac --name "github-terraform-sp" \
     --role Contributor \
     --scopes /subscriptions/<SUBSCRIPTION_ID>
   ```

   Copy the JSON output — you’ll add it to GitHub Secrets later.

3. **Azure Storage Account** and **Blob Container** for Terraform state:

   ```bash
   az group create -n devsecops-cloud_group -l "UK West"
   az storage account create -n devsecopscloudtfstate -g devsecops-cloud_group -l "UK West" --sku Standard_LRS
   az storage container create -n tfstate --account-name devsecopscloudtfstate
   ```

## 🔑 GitHub Secrets

Store the following secrets in your GitHub repository (`Settings > Secrets and variables > Actions`):

| Secret Name             | Description                                                  |
| ----------------------- | ------------------------------------------------------------ |
| `AZURE_CREDENTIALS`     | JSON output from the `az ad sp create-for-rbac` command      |
| `AZURE_STORAGE_ACCOUNT` | Name of your storage account (e.g., `devsecopscloudtfstate`) |
| `SSH_PUBLIC_KEY`        | The public SSH key for VM login                              |
| `ADMIN_USERNAME`        | The admin username for the VM                                |


## 📜 Variables

Defined in `variables.tf`.
Sensitive variables are marked 🔒 and will not be echoed in Terraform logs.

| Variable                        | Description                 | Type         | Default                 | Sensitive |
| ------------------------------- | --------------------------- | ------------ | ----------------------- | --------- |
| `location`                      | Azure region                | string       | `UK West`               | ❌         |
| `resource_group_name`           | Resource group name         | string       | `vm-rg`                 | ❌         |
| `virtual_network_name`          | VNet name                   | string       | `vm-vnet`               | ❌         |
| `address_space`                 | VNet CIDR block             | list(string) | `["10.0.0.0/16"]`       | ❌         |
| `subnet_name`                   | Subnet name                 | string       | `vm-subnet`             | ❌         |
| `subnet_prefix`                 | Subnet CIDR block           | string       | `10.0.1.0/24`           | ❌         |
| `nsg_name`                      | Network Security Group name | string       | `vm-nsg`                | ❌         |
| `nsg_rules`                     | NSG rules                   | list(object) | SSH rule (22/TCP)       | ❌         |
| `public_ip_name`                | Public IP name              | string       | `vm-pip`                | ❌         |
| `public_ip_allocation`          | Static or Dynamic           | string       | `Static`                | ❌         |
| `nic_name`                      | NIC name                    | string       | `vm-nic`                | ❌         |
| `enable_accelerated_networking` | Enable accelerated NIC      | bool         | `false`                 | ❌         |
| `vm_name`                       | VM name                     | string       | `vm-instance`           | ❌         |
| `vm_computer_name`              | Computer hostname           | string       | `vm-computer`           | ❌         |
| `vm_size`                       | VM SKU/size                 | string       | `Standard_B1s`          | ❌         |
| `admin_username` 🔒             | VM admin username           | string       | N/A (from secret)       | ✅         |
| `ssh_public_key` 🔒             | SSH public key for login    | string       | N/A (from secret)       | ✅         |
| `os_disk_type`                  | OS disk type                | string       | `Standard_LRS`          | ❌         |
| `data_disks`                    | Additional disks            | list(object) | `[]`                    | ❌         |
| `AZURE_STORAGE_ACCOUNT`         | Storage account for backend | string       | `devsecopscloudtfstate` | ❌         |


## 🛡️ Security Notes

* Sensitive variables (`admin_username`, `ssh_public_key`) are **not logged** due to `sensitive = true` in `variables.tf`.
* Admin credentials are never stored in plain text — only in **GitHub Secrets**.
* SSH is the only inbound rule enabled by default. Consider restricting `source_address_prefix` to trusted IPs.


## 🧹 Cleanup

Avoid unnecessary costs, and destroy infrastructure when not in use:

    terraform -chdir=VM destroy -auto-approve

Or use the **workflow dispatch** with `destroy`.



✅ This setup enables the design and provisioning of **secure, automated, and repeatable** VMs deployment pipeline on Azure.

