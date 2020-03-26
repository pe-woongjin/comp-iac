# ######################
# COMMON
# ######################
variable "team_name" {
  description = "Team name of DevOps"
  type = string
  default = "Automation"
}

variable "service_name" {
  description = "Service name"
  type = string
  default = "comp"
}

variable "environment" {
  description = "Runtime Environment such as default, develop, stage, production"
  type = string
  default = "prod"
}

variable "aws_region" {
  description = "Region for the Comp"
  type = string
  default = "ap-northeast-2"
}

variable "aws_region_alias" {
  description = "Region name for the Comp"
  type = string
  default = "apne2"
}


# ######################
# VPC
# ######################
# cidr block
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
# Internet Gateway
# Elastic IP
# NAT
# ######################


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
# Launch Configuration
# AutoScaling Group
# ######################


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