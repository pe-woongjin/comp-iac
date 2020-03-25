resource "aws_internet_gateway" "igw" {
  vpc_id = var.vpc_id

  tags = {
    Name        = "${var.service_name}-${var.aws_region_alias}-${var.environment}-igw"
    Environment = var.environment
  }
}