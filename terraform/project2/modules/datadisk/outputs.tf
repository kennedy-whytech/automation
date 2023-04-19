output "md_ids" {
  value = azurerm_managed_disk.md.*.id
}

output "md_names" {
  value = azurerm_managed_disk.md.*.name
}

output "vndda_obj"  {
  value = azurerm_virtual_machine_data_disk_attachment.vndda
}