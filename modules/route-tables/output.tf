# Route table ID
output "public_subnet_route_table_id" {
  description = "Public subnet route table ID"
  value       = aws_route_table.public_subnet_route_table.id
}

output "private_subnet_route_table_id" {
  description = "Private subnet route table ID"
  value = {
    for k, rt in aws_route_table.private_subnet_route_table :
    k => rt.id
  }
}
