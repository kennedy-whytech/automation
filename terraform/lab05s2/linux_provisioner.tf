resource "null_resource" "display_hostnames" {
  depends_on = [azurerm_linux_virtual_machine.lvm]
  count      = var.nb_count
  connection {
    type        = "ssh"
    user        = var.admin_username
    private_key = file(var.private_key)
    host        = azurerm_linux_virtual_machine.lvm[count.index].public_ip_address
  }

  provisioner "remote-exec" {
    inline = [
      "echo 'The hostname of this VM is: ' $(hostname)"
    ]
  }
}
