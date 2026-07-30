output "vpc_id" {
  description = "Jenkins VPC ID"
  value       = aws_vpc.jenkins_vpc.id
}