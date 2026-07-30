## Variable for the security group
variable "vpc_id" {
  description = "VPC ID for the target group"
  type        = string
}

variable "public_subnet_id" {
  description = "Subnet ids for the load balancer"
  type        = map(string)
}

variable "jenkins_lb_sg_id" {
  description = "Security group of the jenkins load balancer"
  type        = string
}

variable "jenkins_master_id" {
  description = "jenkins master id"
  type        = map(string)
}

variable "common_tags" {
  description = "Common tags for the project"
  type        = map(string)
}