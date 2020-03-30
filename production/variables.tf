# ######################
# COMMON
# ######################
variable "team_name" {
  description = "team name of DevOps"
  type = string
}

variable "service_name" {
  description = "name of service"
  type = string
}

variable "service_version" {
  description = "version of service"
  type = string
}

variable "environment" {
  description = "Runtime Environment such as default, develop, stage, production"
  type = string
}

variable "region_name" {
  description = "aws region"
  type = string
}

variable "region_nm" {
  description = "aws region alias"
  type = string
}


# ######################
# VPC
# ######################
# vpc cidr block
variable "vpc_cidr_block" {
  description = "cidr block of vpc"
  type = string
}


# ######################
# Subnet
# ######################
# public subnet
variable "pub_sn_list" {
  description = "public subnets"
  type = list(map(string))
}

# private subnet
variable "mgmt_sn_list" {
  description = "private subnets"
  type = list(map(string))
}


# ######################
# Route Table
# ######################
# public route table
variable "public_rt_tag_names" {
  description = "tag name for public route table"
  type = list(map(string))
}

# private route table
variable "private_rt_tag_names" {
  description = "tag name for private route table"
  type = list(map(string))
}


# ######################
# Security Group
# ######################
# sg cidr block
variable "sg_cidr_block" {
  description = "cidr block of sg"
  type = list(string)
}


# ######################
# ACM
# Route 53
# ######################
# acm
variable "acm_arn" {
  description = "acm arn"
  type = string
}

# route 53 host name
variable "hosts" {
  description = "route 53 host name"
  type = map(string)
}