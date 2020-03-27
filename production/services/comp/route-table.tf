resource "aws_route_table" "pub-rt" {
  vpc_id       = var.vpc_id
  count        = length(var.public_rt_tag_names)
  depends_on   = [aws_internet_gateway.igw]

  route {
    cidr_block  = "0.0.0.0/0"
    gateway_id  = aws_internet_gateway.igw.id
  }

  tags = {
    Name        = "${var.tag_name}-${lookup(var.public_rt_tag_names[count.index], "Name")}"
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
    Name        = "${var.tag_name}-${lookup(var.private_rt_tag_names[count.index], "Name")}"
    Environment = var.environment
  }
}

resource "aws_route_table_association" "pub-rt-ac" {
  count           = length(aws_subnet.pub-sn)

  subnet_id       = aws_subnet.pub-sn.*.id[count.index]
  route_table_id  = aws_route_table.pub-rt.*.id[0]
}

resource "aws_route_table_association" "comp-rt-as-private" {
  count           = length(aws_subnet.mgmt-sn)

  subnet_id       = aws_subnet.mgmt-sn.*.id[count.index]
  route_table_id  = aws_route_table.pri-rt.*.id[0]
}