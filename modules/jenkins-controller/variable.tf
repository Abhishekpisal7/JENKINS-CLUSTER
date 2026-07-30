## Variable for the jenkins controller
variable "jenkins_instance_type" {
  description = "Instance type of the Jenkins"
  type        = string
}

variable "jenkins_key_name" {
  description = "keyname of the jenkins"
  type        = string
}

variable "private_subnet_id" {
  description = "Private subnet ID for the jenkins controller deployment"
  type        = map(string)
}

variable "enable_single_jenkins_master" {
  description = "Option for deploying the multiple controller"
  type        = bool
  default     = true
}

variable "jenkins_master_sg_id" {
  description = "Security group id for the jenkins master"
  type        = string
}

variable "bastion_host_public_ip" {
  description = "Bastion host public ip"
  type        = map(string)
}

variable "common_tags" {
  description = "Common tags of the project"
  type        = map(string)
}