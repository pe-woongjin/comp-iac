/* default management security group for ec2 instances. It helps monitoring, access operationg works like that. */
resource "aws_security_group" "default-ops-sg" {
  name          = "${var.resrc_prefix_nm}-default-ops-sg"
  vpc_id        = var.vpc_id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }

  lifecycle {
    create_before_destroy = true
  }

  tags = {
    Name        = "${var.resrc_prefix_nm}-default-ops-sg"
    Environment = var.environment
  }
}

resource "aws_security_group" "gitlab-sg" {
  name          = "${var.resrc_prefix_nm}-gitlab-sg"
  vpc_id        = var.vpc_id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  lifecycle {
    create_before_destroy = true
  }

  tags = {
    Name        = "${var.resrc_prefix_nm}-gitlab-sg"
    Environment = var.environment
  }
}

/* jenkins + nexus */
resource "aws_security_group" "jenkins-sg" {
  name          = "${var.resrc_prefix_nm}-jenkins-sg"
  vpc_id        = var.vpc_id

  /* jenkins */
  ingress {
    from_port   = 8088
    to_port     = 8088
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }

  /* nexus */
  ingress {
    from_port   = 8081
    to_port     = 8081
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  lifecycle {
    create_before_destroy = true
  }

  tags = {
    Name        = "${var.resrc_prefix_nm}-jenkins-sg"
    Environment = var.environment
  }
}

resource "aws_security_group" "scouter-sg" {
  name          = "${var.resrc_prefix_nm}-scouter-sg"
  vpc_id        = var.vpc_id

  ingress {
    from_port   = 6100
    to_port     = 6100
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  lifecycle {
    create_before_destroy = true
  }

  tags = {
    Name        = "${var.resrc_prefix_nm}-scouter-sg"
    Environment = var.environment
  }
}

resource "aws_security_group" "mgmt-alb-sg" {
  name          = "${var.resrc_prefix_nm}-mgmt-alb-sg"
  vpc_id        = var.vpc_id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  lifecycle {
    create_before_destroy = true
  }

  tags = {
    Name        = "${var.resrc_prefix_nm}-mgmt-alb-sg"
    Environment = var.environment
  }
}