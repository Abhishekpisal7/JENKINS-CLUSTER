## Variables for the VPC 
variable "cidr_block" {
  description = "CIDR block for Jenkins VPC"
  type        = string
}

variable "instance_tenancy" {
  description = "Tenancy of the in VPC"
  type        = string
}

variable "enable_dns_hostnames" {
  description = "Enable DNS hostname for the instances in the VPC"
  type        = bool
}

variable "enable_dns_support" {
  description = "Enable the DNS support in VPC"
  type        = bool
}

variable "common_tags" {
  description = "Common tags for the project"
  type        = map(string)
}