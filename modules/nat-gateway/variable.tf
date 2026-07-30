variable "enable_single_nat_gateway" {
  description = "Enable single nat gatway to minimize the cost"
  type        = bool
}

variable "public_subnet_id" {
  description = "Public subnet id for the nat gateway"
  type        = map(string)
}

variable "common_tags" {
  description = "Common tags for the project"
  type        = map(string)
}