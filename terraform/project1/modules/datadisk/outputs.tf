output "md_ids" {
  value = azurerm_managed_disk.md.*.id
}

output "md_names" {
  value = azurerm_managed_disk.md.*.name
}