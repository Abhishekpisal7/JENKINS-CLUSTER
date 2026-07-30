## Security group IDs for the other module
output "bastion_host_sg_id" {
  description = "Bastion host security group ids"
  value       = aws_security_group.bastion_host_sg.id
}

output "jenkins_master_sg_id" {
  description = "Jenkins master security group id"
  value       = aws_security_group.jenkins_master_sg.id
}

output "jenkins_lb_sg_id" {
  description = "Jenkins load balancer security group"
  value       = aws_security_group.jenkins_lb_sg.id
}

output "jenkins_agent_sg_id" {
  description = "Security group for the jenkins agent"
  value       = aws_security_group.jenkins_agent_sg.id
}