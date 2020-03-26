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


# ######################
# ACM
# Route 53
# ######################
# acm
variable "acm_comp" {
  description = "prefix resource name"
  type = string
}

# gitlab host
variable "gitlab_host" {
  description = "gitlab host name"
  type = string
}

# jenkins host
variable "jenkins_host" {
  description = "jenkins host name"
  type = string
}

# nexus host
variable "nexus_host" {
  description = "nexus host name"
  type = string
}

# sonarqube host
variable "sonarqube_host" {
  description = "sonarqube host name"
  type = string
}