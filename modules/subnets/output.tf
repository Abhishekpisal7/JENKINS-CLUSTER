## Public and Private subnet IDs
output "public_subnet_id" {
  description = "ID of the public subnet"
  value = {
    for k, subnet in aws_subnet.public_subnet : 
      k => subnet.id
    }
}

output "private_subnet_id" {
  description = "ID of the private subnet"
  value = {
    for k, subnet in aws_subnet.private_subnet :   
      k => subnet.id
    }
}