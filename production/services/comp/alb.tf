resource "aws_alb" "mgmt-alb" {
  name               = "${var.service_name}-${var.aws_region_alias}-${var.environment}-mgmt-alb"
  load_balancer_type = "application"
  internal           = false
  subnets            = [aws_subnet.pub-sn[0].id, aws_subnet.pub-sn[1].id]

  security_groups    = [aws_security_group.mgmt-alb-sg.id]

  // NOTE there is a bug in terraform - it can't remove the lb and the whole destroy fails
  enable_deletion_protection = false

  tags = {
    Name        = "${var.service_name}-${var.aws_region_alias}-${var.environment}-mgmt-alb"
    Environment = var.environment
  }
}

resource "aws_alb_target_group" "scm-tg80"  {
  name        = "${var.service_name}-${var.aws_region_alias}-${var.environment}-scm-tg80"
  protocol    = "HTTP"
  port        = 80
  target_type = "instance"
  vpc_id      = var.vpc_id
  depends_on  = [ aws_alb.mgmt-alb ]

  tags = {
    Name        = "${var.service_name}-${var.aws_region_alias}-${var.environment}-scm-tg80"
    Environment = var.environment
  }
}

resource "aws_alb_target_group" "jenkins-tg8088"  {
  name        = "${var.service_name}-${var.aws_region_alias}-${var.environment}-jenkins-tg8088"
  protocol    = "HTTP"
  port        = 8088
  target_type = "instance"
  vpc_id      = var.vpc_id
  depends_on  = [ aws_alb.mgmt-alb ]

  tags = {
    Name        = "${var.service_name}-${var.aws_region_alias}-${var.environment}-jenkins-tg8088"
    Environment = var.environment
  }
}


resource "aws_alb_target_group" "nexus-tg8081"  {
  name        = "${var.service_name}-${var.aws_region_alias}-${var.environment}-nexus-tg8081"
  protocol    = "HTTP"
  port        = 8081
  target_type = "instance"
  vpc_id      = var.vpc_id
  depends_on  = [ aws_alb.mgmt-alb ]

  tags = {
    Name        = "${var.service_name}-${var.aws_region_alias}-${var.environment}-nexus-tg8081"
    Environment = var.environment
  }
}

resource "aws_alb_target_group" "sonarqube-tg9000"  {
  name        = "${var.service_name}-${var.aws_region_alias}-${var.environment}-sonarqube-tg9000"
  protocol    = "HTTP"
  port        = 9000
  target_type = "instance"
  vpc_id      = var.vpc_id
  depends_on  = [ aws_alb.mgmt-alb ]

  tags = {
    Name        = "${var.service_name}-${var.aws_region_alias}-${var.environment}-nexus-tg8081"
    Environment = var.environment
  }
}

resource "aws_alb_listener" "mgmt-alb-listener443" {
  load_balancer_arn = aws_alb.mgmt-alb.arn
  port              = 443
  protocol          = "HTTPS"
  certificate_arn   = var.acm_comp
  depends_on        = [ aws_alb.mgmt-alb, aws_alb_target_group.jenkins-tg8088 ]

  default_action {
    target_group_arn = aws_alb_target_group.jenkins-tg8088.arn
    type             = "forward"
  }
}

resource "aws_alb_listener_rule" "mgmt-alb-listener443-gitlab-rule" {
  listener_arn        = aws_alb_listener.mgmt-alb-listener443.arn
  depends_on          = [ aws_alb_target_group.scm-tg80 ]

  action {
    target_group_arn  = aws_alb_target_group.scm-tg80.arn
    type              = "forward"
  }

  condition {
    host_header {
      values = [var.gitlab_host]
    }
  }
}

resource "aws_alb_listener_rule" "mgmt-alb-listener443-jenkins-rule" {
  listener_arn        = aws_alb_listener.mgmt-alb-listener443.arn
  depends_on          = [ aws_alb_target_group.jenkins-tg8088  ]

  action {
    target_group_arn  = aws_alb_target_group.jenkins-tg8088.arn
    type              = "forward"
  }

  condition {
    host_header {
      values = [var.jenkins_host]
    }
  }
}

resource "aws_alb_listener_rule" "mgmt-alb-listener443-nexus-rule" {
  listener_arn        = aws_alb_listener.mgmt-alb-listener443.arn
  depends_on          = [ aws_alb_target_group.nexus-tg8081  ]

  action {
    target_group_arn  = aws_alb_target_group.nexus-tg8081.arn
    type              = "forward"
  }

  condition {
    host_header {
      values = [var.nexus_host]
    }
  }
}

resource "aws_alb_listener_rule" "mgmt-alb-listener443-sonarqube-rule" {
  listener_arn        = aws_alb_listener.mgmt-alb-listener443.arn
  depends_on          = [ aws_alb_target_group.sonarqube-tg9000  ]

  action {
    target_group_arn  = aws_alb_target_group.sonarqube-tg9000.arn
    type              = "forward"
  }

  condition {
    host_header {
      values = [var.sonarqube_host]
    }
  }
}