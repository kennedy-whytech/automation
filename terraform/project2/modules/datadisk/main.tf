resource "azurerm_managed_disk" "md" {
  count                = length(var.vm_ids)
  name                 = format("%s-vm-%s", element(var.vm_names, count.index), var.disk_name)
  location             = var.rg_location
  resource_group_name  = var.rg_name
  storage_account_type = var.storage_account_type
  create_option        = "Empty"
  disk_size_gb         = var.disk_size_gb
  tags                 = local.common_tags
}

resource "azurerm_virtual_machine_data_disk_attachment" "vndda" {
  count              = length(var.vm_ids)
  managed_disk_id    = azurerm_managed_disk.md[count.index].id
  virtual_machine_id = element(var.vm_ids, count.index)
  lun                = 10
  caching            = "ReadWrite"
  depends_on         = [azurerm_managed_disk.md, var.lvm_obj]
}
  