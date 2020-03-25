# ######################
# COMMON
# ######################
variable "environment" {
  description = "Runtime Environment such as default, develop, stage, production"
  type = string
}

variable "service_name" {
  description = "name of vpc"
  type = string
}

variable "aws_region_alias" {
  description = "aws region alias of prefix"
  type = string
}

variable "acm-opsflex" {
  description = "prefix resource name"
  type = string
  default = "arn:aws:acm:ap-northeast-2:144149479695:certificate/f18b5da0-218d-44cc-a28c-a3774bbd7641"
}


# ######################
# VPC
# ######################
# vpc id
variable "vpc_id" {
  type        = string
  description = "count of loop"
}

variable "vpc_cidr_block" {
  description = "cidr block of vpc"
  type = string
}


# ######################
# Subnet
# ######################
# subnet
variable "pub_sn_list" {
  description = "public subnets"
  type = list(map(string))
}

# subnet
variable "mgmt_sn_list" {
  description = "private subnets"
  type = list(map(string))
}


# ######################
# Route Table
# ######################
# route table
variable "public_rt_tag_names" {
  description = "tag name for public route table"
  type = list(map(string))
}

# route table
variable "private_rt_tag_names" {
  description = "tag name for private route table"
  type = list(map(string))
}


# ######################
# Security Group
# ######################
# sg cidr block
variable "sg_cidr_block" {
  description = "sg cidr block"
  type = list(string)
}