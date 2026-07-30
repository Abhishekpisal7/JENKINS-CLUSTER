## locals
env = "dev"

## vpc
region               = "ap-south-1"
cidr_block           = "10.0.0.0/16"
instance_tenancy     = "default"
enable_dns_hostnames = true
enable_dns_support   = true

## subnets
availability_zone         = ["ap-south-1a", "ap-south-1b"]
public_subnet_cidr_block  = ["10.0.1.0/24", "10.0.2.0/24"]
private_subnet_cidr_block = ["10.0.3.0/24", "10.0.4.0/24"]

## nat gateway 
enable_single_nat_gateway = true

## bastion host 
enable_single_bastion_host = true
bastion_host_ami           = "ami-001e7cc215773c7fb"
bastion_host_instance_type = "t2.micro"
bastion_host_key_name      = "newkey"

## jenkins controller
enable_single_jenkins_master = true
jenkins_instance_type        = "t2.medium"
jenkins_key_name             = "newkey"

## jenkins agent in autoscaling
jenkins_agent_instance_type = "t2.medium"
jenkins_agent_key_name      = "newkey"
jenkins_username            = "Abhishek"
jenkins_password            = "Abhishek@2543"
jenkins_credentials_id      = "Jenkins-workers"