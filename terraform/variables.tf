# =============================================
# General Configuration
# =============================================

variable "resource_group_name" {
  description = "Base name for resource group"
  type        = string
  default     = "Mini_Finance"
}

variable "location" {
  description = "Default Azure region (used as fallback)"
  type        = string
  default     = "centralindia"
}

# =============================================
# VM Configuration
# =============================================

variable "vm_size" {
  description = "Size of the Azure VMs"
  type        = string
  default     = "Standard_B2ts_v2"
}

variable "admin_user" {
  description = "Username for the VM administrator"
  type        = string
  default     = "azureuser"
}

variable "ssh_public_key_path" {
  description = "Path to the SSH public key file"
  type        = string
  default     = "~/.ssh/azure_rsa.pub"
}



# =============================================
# Optional / Advanced Variables
# =============================================

variable "environment" {
  description = "Environment tag (dev, test, prod, etc.)"
  type        = string
  default     = "Mini_Finance"
}

variable "common_tags" {
  description = "Common tags to apply to all resources"
  type        = map(string)
  default = {
    environment = "nini_Finance"
    project     = "Mini_FInance_Deployment"
    managed_by  = "terraform"
  }
}
