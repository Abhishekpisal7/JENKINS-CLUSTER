## Variables for the subnets
variable "vpc_id" {
  description = "VPC ID for subnets"
  type        = string
}

variable "availability_zone" {
  description = "Availability zone for the subnets"
  type        = list(string)
}

variable "public_subnet_cidr_block" {
  description = "CIDR block for the public subnets"
  type        = list(string)
}

variable "private_subnet_cidr_block" {
  description = "CIDR block for the private subnet"
}

variable "common_tags" {
  description = "common tags of the project"
  type        = map(string)
}