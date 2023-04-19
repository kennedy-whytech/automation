resource "null_resource" "display_hostnames" {
  depends_on = [azurerm_linux_virtual_machine.lvm, var.vndda_obj]
  count      = var.nb_count
  connection {
    type        = "ssh"
    user        = var.admin_username
    private_key = file(var.private_key)
    host        = azurerm_linux_virtual_machine.lvm[count.index].public_ip_address
  }

  provisioner "remote-exec" {
    inline = [
      "echo 'The hostname of this VM is: ' $(hostname)",
      /*
      "sudo yum update -y",
      "sudo yum install -y httpd",
      "sudo systemctl enable httpd",
      "sudo sh -c 'echo \"<h1>This website is hosted on $(hostname)</h1>\" > /var/www/html/index.html'",
      "sudo systemctl start httpd",
      "sudo yum install -y firewalld",
      "sudo systemctl start firewalld",
      "sudo firewall-cmd --permanent --add-service=http",
      "sudo firewall-cmd --permanent --add-service=https",
      "sudo firewall-cmd --reload",
      */
    ]
  }
   provisioner "local-exec" {

    command = "sleep 30 && ansible-playbook ../../ansible/project2/groupX-playbook.yml"
  }
}
