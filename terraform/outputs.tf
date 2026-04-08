output "vm_public_ip" {
  description = "Public IP Address of the VM"
  value       = azurerm_public_ip.pip.ip_address
}

output "vm_ssh_command" {
  description = "Ready-to-use SSH command for the VM"
  value       = "ssh -i ~/.ssh/azure_rsa ${var.admin_user}@${azurerm_public_ip.pip.ip_address}"
}

