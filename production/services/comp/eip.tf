resource "aws_eip" "eip" {
  vpc         = true
  depends_on  = [aws_internet_gateway.igw]

  tags = {
    Name        = "${var.tag_name}-eip"
    Environment = var.environment
  }
}