# ######################
# COMMON
# ######################
variable "environment" {
  description = "Runtime Environment such as default, develop, stage, production"
  type = string
}

variable "svc_prefix_nm" {
  description = "svc prefix name"
  type = string
}

variable "resrc_prefix_nm" {
  description = "resource prefix name"
  type = string
}


# ######################
# VPC
# ######################
# vpc id
variable "vpc_id" {
  type        = string
  description = "vpc id"
}

# vpc cidr block
variable "vpc_cidr_block" {
  description = "cidr block of vpc"
  type = string
}


# ######################
# Subnet
# ######################
# public subnet
variable "pub_sn_ids" {
  description = "public subnets id"
  type = list(string)
}


# ######################
# Security Group
# ######################
# sg cidr block
variable "sg_cidr_block" {
  description = "cidr block of sg"
  type = list(string)
}

# mgmt sg id
variable "mgmt_sg_id" {
  description = "mgmt sg id"
  type = string
}


# ######################
# Target Group
# ######################
# target group of scm
variable "gitlab-tg80" {
  description = "target group of gitlab"
}

# target group of gitlab
variable "gitlab-ssh-tg22" {
  description = "target group of gitlab"
}

# target group of scm
variable "scm-tg80" {
  description = "target group of scm"
}

# target group of scm
variable "jenkins-tg8088" {
  description = "target group of jenkins"
}

# target group of scm
variable "nexus-tg8081" {
  description = "target group of nexus"
}

# target group of scouter
variable "scouter-tg6100" {
  description = "target group of scouter"
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