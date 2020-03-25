# ######################
# COMMON
# ######################
# team
team_name = "Automation"

# service name
service_name = "comp"

# env
environment = "prod"

# region
aws_region = "ap-northeast-2"
aws_region_alias = "apne2"


# ######################
# VPC
# ######################
# cidr block
vpc_cidr_block = "10.40.0.0/16"


# ######################
# Subnet
# ######################
# subnet public
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

# subnet toolchain private
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
# Internet Gateway
# Elastic IP
# NAT
# ######################


# ######################
# Route Table
# ######################
# route table
public_rt_tag_names = [
  {
    Name = "pub-rt"
  }
]

# route table
private_rt_tag_names = [
  {
    Name = "pri-rt"
  }
]


# ######################
# Security Group
# ######################
sg_cidr_block = ["58.151.93.9/32", "58.151.93.2/32"]


# ######################
# Launch Configuration
# AutoScaling Group
# ######################