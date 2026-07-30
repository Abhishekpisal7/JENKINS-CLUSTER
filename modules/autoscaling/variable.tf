variable "private_subnet_id" {
  description = "Private subnet id for the jenkins agent"
  type        = map(string)
}

variable "jenkins_agent_instance_type" {
  description = "Instance type of the jenkins agent"
  type        = string
}

variable "jenkins_agent_key_name" {
  description = "Key name of the jenkins"
  type        = string
}

variable "jenkins_agent_sg_id" {
  description = "Security group for the jenkins agent"
  type        = string
}

variable "common_tags" {
  description = "Common tags for the project"
  type        = map(string)
}
variable "jenkins_private_ip" {
  description = "Jenkins private ip for the URL"
  type        = map(string)
}

variable "jenkins_username" {
  description = "Jenkins username for the worker node"
  type        = string
}

variable "jenkins_password" {
  description = "Jenkins password for the worker node"
  type        = string
}

variable "jenkins_credentials_id" {
  description = "ID of the jenkins credentials"
  type        = string
}

variable "jenkins_lb_arn_suffix" {
  description = "Load balancer arn suffix"
  type        = string
}

variable "jenkins_lb_targert_group_arn_suffix" {
  description = "Target group arn suffix"
  type        = string
}