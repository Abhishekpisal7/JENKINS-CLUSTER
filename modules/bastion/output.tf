## bastion host output block
output "bastion_host_id" {
  description = "Bastion host instance ID"
  value = {
    for k, instance in aws_instance.bastion_host :
    k => instance.id
  }
}

output "bastion_host_public_ip" {
  description = "Bastion host public IP"
  value = {
    for k, instance in aws_instance.bastion_host :
    k => instance.public_ip
  }
}