## bastion host for the jenkins cluster project.
resource "aws_instance" "bastion_host" {
  for_each               = tomap(local.target_subnet)
  ami                    = var.bastion_host_ami
  instance_type          = var.bastion_host_instance_type
  key_name               = var.bastion_host_key_name
  availability_zone      = each.key
  subnet_id              = each.value
  vpc_security_group_ids = [var.bastion_host_sg_id]

  provisioner "file" {
    source      = "../../files/newkey.pem"
    destination = "/home/ubuntu/.ssh/newkey.pem"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo apt update",
      "sudo chmod 400 /home/ubuntu/.ssh/newkey.pem"
    ]
  }

  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = file("../../files/newkey.pem")
    host        = self.public_ip
  }

  tags = merge(
    var.common_tags,
    {
      "Name" = "${each.key}-bastion-host"
    }
  )
}