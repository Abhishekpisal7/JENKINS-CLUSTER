module "vpc" {
  source = "../../modules/vpc"

  cidr_block           = var.cidr_block
  instance_tenancy     = var.instance_tenancy
  enable_dns_hostnames = var.enable_dns_hostnames
  enable_dns_support   = var.enable_dns_support

  common_tags = local.common_tags
}

module "internet_gateway" {
  source = "../../modules/internet-gateway"

  vpc_id = module.vpc.vpc_id

  common_tags = local.common_tags
}

module "nat_gateway" {
  source = "../../modules/nat-gateway"

  enable_single_nat_gateway = var.enable_single_nat_gateway
  public_subnet_id          = module.subnets.public_subnet_id

  common_tags = local.common_tags
}

module "subnets" {
  source = "../../modules/subnets"

  vpc_id                    = module.vpc.vpc_id
  availability_zone         = var.availability_zone
  public_subnet_cidr_block  = var.public_subnet_cidr_block
  private_subnet_cidr_block = var.private_subnet_cidr_block

  common_tags = local.common_tags
}

module "route_tables" {
  source = "../../modules/route-tables"

  vpc_id                    = module.vpc.vpc_id
  availability_zone         = var.availability_zone
  internet_gateway_id       = module.internet_gateway.internet_gateway_id
  nat_gateway_id            = module.nat_gateway.nat_gateway_id
  public_subnet_id          = module.subnets.public_subnet_id
  private_subnet_id         = module.subnets.private_subnet_id
  enable_single_nat_gateway = var.enable_single_nat_gateway

  common_tags = local.common_tags
}

module "security_group" {
  source = "../../modules/security-groups"

  vpc_id     = module.vpc.vpc_id
  cidr_block = var.cidr_block

  common_tags = local.common_tags
}

module "bastion_host" {
  source = "../../modules/bastion"

  bastion_host_ami           = var.bastion_host_ami
  enable_single_bastion_host = var.enable_single_bastion_host
  bastion_host_instance_type = var.bastion_host_instance_type
  bastion_host_key_name      = var.bastion_host_key_name
  bastion_host_sg_id         = module.security_group.bastion_host_sg_id
  public_subnet_id           = module.subnets.public_subnet_id

  common_tags = local.common_tags
}

module "jenkins_controller" {
  source = "../../modules/jenkins-controller"

  jenkins_instance_type        = var.jenkins_instance_type
  jenkins_key_name             = var.jenkins_key_name
  enable_single_jenkins_master = var.enable_single_jenkins_master
  jenkins_master_sg_id         = module.security_group.jenkins_master_sg_id
  private_subnet_id            = module.subnets.private_subnet_id
  bastion_host_public_ip       = module.bastion_host.bastion_host_public_ip

  common_tags = local.common_tags
}

module "alb" {
  source = "../../modules/alb"

  vpc_id            = module.vpc.vpc_id
  public_subnet_id  = module.subnets.public_subnet_id
  jenkins_lb_sg_id  = module.security_group.jenkins_lb_sg_id
  jenkins_master_id = module.jenkins_controller.jenkins_controller_id

  common_tags = local.common_tags
}

module "autoscaling" {
  source = "../../modules/autoscaling"

  private_subnet_id                   = module.subnets.private_subnet_id
  jenkins_agent_sg_id                 = module.security_group.jenkins_agent_sg_id
  jenkins_private_ip                  = module.jenkins_controller.jenkins_controller_private_ip
  jenkins_lb_arn_suffix               = module.alb.jenkins_lb_arn_suffix
  jenkins_lb_targert_group_arn_suffix = module.alb.jenkins_lb_targert_group_arn_suffix
  jenkins_username                    = var.jenkins_username
  jenkins_password                    = var.jenkins_password
  jenkins_credentials_id              = var.jenkins_credentials_id
  jenkins_agent_key_name              = var.jenkins_agent_key_name
  jenkins_agent_instance_type         = var.jenkins_agent_instance_type

  common_tags = local.common_tags
}