resource "aws_route_table" "pub-rt" {
  vpc_id       = var.vpc_id
  count        = length(var.public_rt_tag_names)
  depends_on   = [aws_internet_gateway.igw]

  route {
    cidr_block  = "0.0.0.0/0"
    gateway_id  = aws_internet_gateway.igw.id
  }

  tags = {
    Name        = "${var.service_name}-${var.aws_region_alias}-${var.environment}-${lookup(var.public_rt_tag_names[count.index], "Name")}"
    Environment = var.environment
  }
}

resource "aws_route_table" "pri-rt" {
  vpc_id            = var.vpc_id
  count             = length(var.private_rt_tag_names)
  depends_on        = [aws_internet_gateway.igw, aws_nat_gateway.nat]

  route {
    cidr_block      = "0.0.0.0/0"
    nat_gateway_id  = aws_nat_gateway.nat.id
  }

  tags = {
    Name        = "${var.service_name}-${var.aws_region_alias}-${var.environment}-${lookup(var.private_rt_tag_names[count.index], "Name")}"
    Environment = var.environment
  }
}

# route table association
resource "aws_route_table_association" "pub-rt-ac" {
  count           = length(aws_subnet.pub-sn)

  subnet_id       = aws_subnet.pub-sn.*.id[count.index]
  route_table_id  = aws_route_table.pub-rt.*.id[0]
}

resource "aws_route_table_association" "opsflex-rt-as-private" {
  count           = length(aws_subnet.mgmt-sn)

  subnet_id       = aws_subnet.mgmt-sn.*.id[count.index]
  route_table_id  = aws_route_table.pri-rt.*.id[0]
}