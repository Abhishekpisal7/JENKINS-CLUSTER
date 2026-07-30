locals {
  target_subnet = var.enable_single_jenkins_master ? { keys(var.private_subnet_id)[0] = values(var.private_subnet_id)[0] } : var.private_subnet_id
}