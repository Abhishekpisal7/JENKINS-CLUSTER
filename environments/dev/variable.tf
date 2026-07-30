## locals
variable "env" {
  description = "Environment of development"
  type        = string
}

## VPC variable 
variable "region" {
  description = "Region of the AWS"
  type        = string
}

variable "cidr_block" {
  description = "CIDR block for Jenkins VPC"
  type        = string
}

variable "instance_tenancy" {
  description = "Tenancy of the instance in VPC"
  type        = string
}

variable "enable_dns_hostnames" {
  description = "Enable DNS hostname inside VPC"
  type        = bool
}

variable "enable_dns_support" {
  description = "Enable DNS support inside VPC"
  type        = bool
}

## subnets variables
variable "availability_zone" {
  description = "Availability zones for the subnets"
  type        = list(string)
}

variable "public_subnet_cidr_block" {
  description = "CIDR block for the public subnet"
  type        = list(string)
}

variable "private_subnet_cidr_block" {
  description = "CIDR block for the private subnet"
  type        = list(string)
}

## nat veraibles
variable "enable_single_nat_gateway" {
  description = "Select wheater enable single nat gateway or multiple nat gatway"
  type        = bool
}

## bastion host AMI ids
variable "enable_single_bastion_host" {
  description = "enable single bastion host"
  type        = bool
}

variable "bastion_host_ami" {
  description = "AMI for the bastion host."
  type        = string
}

variable "bastion_host_instance_type" {
  description = "Instance type for the bastion host"
  type        = string
}

variable "bastion_host_key_name" {
  description = "Key name for the bastion host"
  type        = string
}

## for jenkins controller
variable "jenkins_instance_type" {
  description = "Instance type of the jenkins controller"
  type        = string
}

variable "jenkins_key_name" {
  description = "Keyname for the jenkins controller"
  type        = string
}

variable "enable_single_jenkins_master" {
  type = bool
}

## for jenkins agent in autoscaling
variable "jenkins_agent_instance_type" {
  description = "Instance type of the jenkins agent"
  type        = string
}

variable "jenkins_agent_key_name" {
  description = "Key for the jenkins agent"
  type        = string
}

variable "jenkins_username" {
  description = "Username for the jenkins"
  type        = string
}

variable "jenkins_password" {
  description = "Password for the jenkins"
  type        = string
}

variable "jenkins_credentials_id" {
  description = "Credential id for the jenkins"
  type        = string
}
