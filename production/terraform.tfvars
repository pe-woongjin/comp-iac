# ######################
# COMMON
# ######################
# team
team_name = "Automation"

# service name
service_name = "comp"

# service version
service_version = "0.2"

# env
environment = "prod"

# region
region_name = "ap-northeast-2"
region_nm = "apne2"


# ######################
# VPC
# ######################
# vpc cidr block
vpc_cidr_block = "10.40.0.0/16"


# ######################
# Subnet
# ######################
# public subnet
pub_sn_list = [
  {
    cidr_block = "10.40.10.0/24",
    availability_zone = "ap-northeast-2a",
    Name = "pub-1a-sn"
  },
  {
    cidr_block = "10.40.11.0/24",
    availability_zone = "ap-northeast-2c",
    Name = "pub-1c-sn"
  }
]

# private subnet
mgmt_sn_list = [
  {
    cidr_block = "10.40.20.0/24",
    availability_zone = "ap-northeast-2a",
    Name = "mgmt-1a-sn"
  },
  {
    cidr_block = "10.40.21.0/24",
    availability_zone = "ap-northeast-2c",
    Name = "mgmt-1c-sn"
  }
]


# ######################
# Route Table
# ######################
# public route table
public_rt_tag_names = [
  {
    Name = "pub-rt"
  }
]

# private route table
private_rt_tag_names = [
  {
    Name = "pri-rt"
  }
]


# ######################
# Security Group
# ######################
# sg cidr block
sg_cidr_block = ["58.151.93.9/32", "58.151.93.2/32"]


# ######################
# ACM
# Route 53
# ######################
# acm
acm_arn = "arn:aws:acm:ap-northeast-2:144149479695:certificate/efc7a467-526d-4476-b91f-ef69f146c6a6"

# route 53 host name
hosts = {
  "gitlab" = "scm.mingming.shop"
  "jenkins" = "jenkins.mingming.shop"
  "nexus" = "nexus.mingming.shop"
  "scouter" = "scouter.mingming.shop"
}