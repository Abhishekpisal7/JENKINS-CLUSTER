# Public route table 
resource "aws_route_table" "public_subnet_route_table" {
  vpc_id = var.vpc_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = var.internet_gateway_id
  }

  tags = merge(
    var.common_tags,
    {
      "Name" = "public-route-table"
    }
  )
}

# public route table association
resource "aws_route_table_association" "public_subnet_rt_association" {
  for_each       = tomap(var.public_subnet_id)
  route_table_id = aws_route_table.public_subnet_route_table.id
  subnet_id      = each.value
}

# Private subnet route table
resource "aws_route_table" "private_subnet_route_table" {
  for_each = tomap(local.target_nat_gateway)
  vpc_id   = var.vpc_id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = var.nat_gateway_id[each.value]
  }

  tags = merge(
    var.common_tags,
    {
      "Name" = "${each.key}-private-subnet-route-table"
    }
  )
}

# Private subnet route table association
resource "aws_route_table_association" "private_subnet_rt_association" {
  for_each       = tomap(var.private_subnet_id)
  route_table_id = aws_route_table.private_subnet_route_table[each.key].id
  subnet_id      = each.value
}