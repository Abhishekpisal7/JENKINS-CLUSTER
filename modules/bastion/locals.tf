locals {
  target_subnet = var.enable_single_bastion_host ? { keys(var.public_subnet_id)[0] = values(var.public_subnet_id)[0] } : var.public_subnet_id
}