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

  # common
  team_name = var.team_name
  environment = var.environment
  aws_region_alias = var.aws_region_alias
  service_name = var.service_name
  service_version = var.service_version
  tag_name = var.tag_name

  # vpc
  vpc_cidr_block = var.vpc_cidr_block
}

module "comp" {
  source = "./services/comp"

  # common
  environment = var.environment
  tag_name = var.tag_name

  # vpc
  vpc_id = module.vpc.id
  vpc_cidr_block = var.vpc_cidr_block

  # subnets
  pub_sn_list = var.pub_sn_list
  mgmt_sn_list = var.mgmt_sn_list

  # route table
  public_rt_tag_names = var.public_rt_tag_names
  private_rt_tag_names = var.private_rt_tag_names

  # sg
  sg_cidr_block = var.sg_cidr_block
}


module "elb" {
  source = "./elb"

  # common
  environment = var.environment
  tag_name = var.tag_name

  # vpc
  vpc_id = module.vpc.id
  vpc_cidr_block = var.vpc_cidr_block

  # subnets
  pub_sn_ids = module.comp.pub_sn_ids

  # sg
  sg_cidr_block = var.sg_cidr_block
  mgmt_sg_id = module.comp.mgmt_sg_id

  # acm
  acm_arn = var.acm_arn

  # host
  host = var.host
}