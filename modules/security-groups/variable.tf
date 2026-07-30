## variable for the security group
variable "vpc_id" {
  description = "VPC ID for the security group"
  type        = string
}

variable "cidr_block" {
  description = "CIDR block for the security group"
  type        = string
}

variable "common_tags" {
  description = "Common tags for the project"
  type        = map(string)
}