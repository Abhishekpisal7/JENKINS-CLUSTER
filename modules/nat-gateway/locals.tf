locals {
  target_azs = var.enable_single_nat_gateway ? { keys(var.public_subnet_id)[0] = values(var.public_subnet_id)[0] } : var.public_subnet_id
}
