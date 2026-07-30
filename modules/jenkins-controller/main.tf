## Jenkins controller configuration
resource "aws_instance" "jenkins_master" {
  for_each               = tomap(local.target_subnet)
  ami                    = data.aws_ami.jenkins_master.id
  instance_type          = var.jenkins_instance_type
  key_name               = var.jenkins_key_name
  availability_zone      = each.key
  subnet_id              = each.value
  vpc_security_group_ids = [var.jenkins_master_sg_id]

  root_block_device {
    volume_type = "gp3"
    volume_size = "20"
  }

  tags = merge(
    var.common_tags,
    {
      "Name" = "${each.key}-jenkins-controller"
    }
  )
}