## Public subnet configuration
resource "aws_subnet" "public_subnet" {
  for_each                = zipmap(var.availability_zone, var.public_subnet_cidr_block)
  vpc_id                  = var.vpc_id
  availability_zone       = each.key
  cidr_block              = each.value
  map_public_ip_on_launch = true

  tags = merge(
    var.common_tags,
    {
      "Name" = "${each.key}-public-subnet"
    }
  )
}

## Private subnet configuration
resource "aws_subnet" "private_subnet" {
  for_each                = zipmap(var.availability_zone, var.private_subnet_cidr_block)
  vpc_id                  = var.vpc_id
  availability_zone       = each.key
  cidr_block              = each.value
  map_public_ip_on_launch = false

  tags = merge(
    var.common_tags,
    {
      "Name" = "${each.key}-private-subnet"
    }
  )
}