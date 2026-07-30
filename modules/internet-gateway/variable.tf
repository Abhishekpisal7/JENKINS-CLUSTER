variable "vpc_id" {
  description = "VPC ID for the internet gateway"
  type        = string
}

variable "common_tags" {
  description = "common tags of the project"
  type        = map(string)
}