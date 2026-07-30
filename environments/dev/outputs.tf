output "vpc_id" {
  description = "VPC ID of the jenkins vpc"
  value       = module.vpc.vpc_id
}

## Internet and NAT Gateway ID
output "internet_gateway_id" {
  description = "Internet gateway ID"
  value       = module.internet_gateway.internet_gateway_id
}

output "nat_gateway_id" {
  description = "Nat gateway ID"
  value       = module.nat_gateway.nat_gateway_id
}

## Public and Private Subnet IDs
output "public_subnet_id" {
  description = "Public subnet ID"
  value       = module.subnets.public_subnet_id
}

output "private_subnet_id" {
  description = "Private subnet ID"
  value       = module.subnets.private_subnet_id
}

## Public and Private route table IDs
output "public_subnet_route_table_id" {
  description = "Public subnet route table ID"
  value       = module.route_tables.public_subnet_route_table_id
}

output "private_subnet_route_table_id" {
  description = "Private subnet route table ID"
  value       = module.route_tables.private_subnet_route_table_id
}

## bastion host deatails
output "bastion_host_public_ip" {
  description = "Public IP of the bastion host instance"
  value       = module.bastion_host.bastion_host_public_ip
}

## jenkins controller
output "jenkins_controller_private_ip" {
  description = "Public IPV4 address of the jenkins controller"
  value       = module.jenkins_controller.jenkins_controller_private_ip
}

## DNS name of the jenkins load balancer
output "jenkins_load_balancer" {
  description = "DNS name of the load balancer"
  value       = "http://${module.alb.load_balancer_dns}"
}