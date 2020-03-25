variable "vpc_cidr_block" {
  description = "cidr block of vpc"
  type = string
}

variable "team_name" {
  description = "Team name of DevOps"
  type = string
}

variable "service_name" {
  description = "name of vpc"
  type = string
}

variable "environment" {
  description = "Runtime Environment such as default, develop, stage, production"
  type = string
}

variable "aws_region_alias" {
  description = "aws region alias of prefix"
  type = string
}