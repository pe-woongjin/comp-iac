resource "aws_vpc" "comp" {
  cidr_block            = var.vpc_cidr_block

  enable_dns_hostnames  = true
  enable_dns_support    = true
  instance_tenancy      = "default"

  tags  = {
    Name        = "${var.resrc_prefix_nm}-vpc"
    Environment = var.environment
    Team        = var.team_name
    Version     = var.service_version
  }
}