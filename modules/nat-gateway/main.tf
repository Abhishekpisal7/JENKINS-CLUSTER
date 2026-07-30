## Elastic IP for the NAT gateway
resource "aws_eip" "nat_eip" {
  for_each = tomap(local.target_azs)
  domain   = "vpc"

  tags = merge(
    var.common_tags
  )
}

## NAT gateway
resource "aws_nat_gateway" "nat_gateway" {
  for_each      = tomap(local.target_azs)
  allocation_id = aws_eip.nat_eip[each.key].id
  subnet_id     = each.value

  tags = merge(
    var.common_tags,
    {
      "Name" = "${each.key}-nat-gateway"
    }
  )
}