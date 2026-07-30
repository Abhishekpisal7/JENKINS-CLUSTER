output "load_balancer_dns" {
  description = "DNS name of the load balancer"
  value       = aws_lb.jenkins_lb.dns_name
}

output "jenkins_lb_arn_suffix" {
  description = "Load balancer arn suffix for autoscaling policy"
  value       = aws_lb.jenkins_lb.arn_suffix
}

output "jenkins_lb_targert_group_arn_suffix" {
  description = "target group arn suffix"
  value       = aws_lb_target_group.jenkins_lb_targert_group.arn_suffix
}