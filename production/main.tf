terraform {
  required_version = "~> 0.12.20"
  backend "local" {}
}

provider "aws" {
  shared_credentials_file = "~/.aws/credentials"
  region = var.aws_region
  version = "~> 2.51"
}

module "vpc" {
  source = "./vpc"

  team_name = var.team_name
  environment = var.environment
  aws_region_alias = var.aws_region_alias

  service_name = var.service_name
  vpc_cidr_block = var.vpc_cidr_block
}


module "opsflex" {
  source = "./services/opsflex"

  # service name
  service_name = var.service_name

  # runtime environment
  environment = var.environment

  # region name
  aws_region_alias = var.aws_region_alias

  # vpc
  vpc_id = module.vpc.id
  vpc_cidr_block = var.vpc_cidr_block

  # for subnets
  pub_sn_list = var.pub_sn_list
  mgmt_sn_list = var.mgmt_sn_list

  # for route table
  public_rt_tag_names = var.public_rt_tag_names
  private_rt_tag_names = var.private_rt_tag_names

  # for sg
  sg_cidr_block = var.sg_cidr_block

}