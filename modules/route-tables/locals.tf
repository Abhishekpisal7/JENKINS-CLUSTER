locals {
  target_nat_gateway = var.enable_single_nat_gateway ? zipmap(var.availability_zone, [for i in var.availability_zone : var.availability_zone[0]]) : zipmap(var.availability_zone, var.availability_zone)
}