## variables for the bastion hosts
variable "public_subnet_id" {
  description = "Public subnet ID for the bastion host"
  type        = map(string)
}

variable "enable_single_bastion_host" {
  description = "enable single bastion host for cost saving"
  type        = bool
  default     = true
}

variable "bastion_host_ami" {
  description = "AMI ID for the bastion host"
  type        = string
}

variable "bastion_host_instance_type" {
  description = "Instance type for the bastion host"
  type        = string
}
variable "bastion_host_key_name" {
  description = "Key to login into the bastion host"
  type        = string
}

variable "bastion_host_sg_id" {
  description = "Security group for the bastion host"
  type        = string
}

variable "common_tags" {
  description = "common tags for the project"
  type        = map(string)
}