resource "aws_vpc" "opsflex" {
  cidr_block = var.vpc_cidr_block

  enable_dns_hostnames = true
  enable_dns_support = true
  instance_tenancy = "default"

  tags  = {
    Name = "${var.service_name}-${var.aws_region_alias}-${var.environment}-vpc"
    Environment = var.environment
    Team = var.team_name
    Version = "0.0.1"
  }
}