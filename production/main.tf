terraform {
  required_version = "~> 0.12.20"
  backend "local" {}
}

provider "aws" {
  shared_credentials_file = "~/.aws/credentials"
  region = var.region_name
  version = "~> 2.51"
}

module "vpc" {
  source = "./modules/vpc"

  # common
  team_name = var.team_name
  service_name = var.service_name
  service_version = var.service_version
  environment = var.environment
  region_nm = var.region_nm
  svc_prefix_nm = "${var.service_name}-${var.environment}"
  resrc_prefix_nm = "${var.service_name}-${var.region_nm}-${var.environment}"

  # vpc
  vpc_cidr_block = var.vpc_cidr_block
}

module "comp" {
  source = "./services/comp"

  # common
  environment = var.environment
  svc_prefix_nm = "${var.service_name}-${var.environment}"
  resrc_prefix_nm = "${var.service_name}-${var.region_nm}-${var.environment}"

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
  source = "./modules/elb"

  # common
  environment = var.environment
  svc_prefix_nm = "${var.service_name}-${var.environment}"
  resrc_prefix_nm = "${var.service_name}-${var.region_nm}-${var.environment}"

  # vpc
  vpc_id = module.vpc.id
  vpc_cidr_block = var.vpc_cidr_block

  # subnets
  pub_sn_ids = module.comp.pub_sn_ids

  # sg
  sg_cidr_block = var.sg_cidr_block
  mgmt_sg_id = module.comp.mgmt_sg_id

  # tg
  gitlab-tg80 = module.comp.gitlab-tg80
  gitlab-ssh-tg22 = module.comp.gitlab-ssh-tg22
  scm-tg80 = module.comp.scm-tg80
  jenkins-tg8088 = module.comp.jenkins-tg8088
  nexus-tg8081 = module.comp.nexus-tg8081
  scouter-tg6100 = module.comp.scouter-tg6100

  # acm
  acm_arn = var.acm_arn

  # host
  hosts = var.hosts
}