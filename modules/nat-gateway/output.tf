output "nat_gateway_id" {
  description = "Nat gateway ID"
  value = {
    for k, nat in aws_nat_gateway.nat_gateway :
    k => nat.id
  }
}