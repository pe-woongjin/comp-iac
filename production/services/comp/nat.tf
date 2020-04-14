resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.eip.id
  subnet_id     = aws_subnet.pub-sn[0].id
  depends_on    = [aws_internet_gateway.igw, aws_eip.eip]

  tags = {
    Name        = "${var.resrc_prefix_nm}-nat"
    Environment = var.environment
  }
}