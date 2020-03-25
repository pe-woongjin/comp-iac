resource "aws_eip" "eip" {
  vpc         = true
  depends_on  = [aws_internet_gateway.igw]

  tags = {
    Name        = "${var.service_name}-${var.aws_region_alias}-${var.environment}-eip"
    Environment = var.environment
  }
}