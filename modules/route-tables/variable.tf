# Variable for the route table
variable "vpc_id" {
  description = "VPC ID for the route table"
  type        = string
}

variable "internet_gateway_id" {
  description = "Internet gateway ID for the route table"
  type        = string
}

variable "nat_gateway_id" {
  description = "nat gateway ID for the private route table"
  type        = map(string)
}

variable "public_subnet_id" {
  description = "Public subnet ID for the route table assocaition"
  type        = map(string)
}

variable "private_subnet_id" {
  description = "Private subnet ID for the route table assocaition"
  type        = map(string)
}

variable "availability_zone" {
  description = "Availablity zone for the route table"
  type        = list(string)
}

variable "common_tags" {
  description = "common tags for the project"
  type        = map(string)
}

variable "enable_single_nat_gateway" {
  description = "Enable single nat gateway"
  type        = bool
}