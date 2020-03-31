resource "aws_internet_gateway" "igw" {
  vpc_id = var.vpc_id

  tags = {
    Name        = "${var.resrc_prefix_nm}-igw"
    Environment = var.environment
  }
}