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

variable "aws_region_alias" {
  description = "aws region alias"
  type = string
}

variable "tag_name" {
  description = "tag name"
  type = string
}

variable "vpc_cidr_block" {
  description = "cidr block of vpc"
  type = string
}