resource "aws_alb" "mgmt-alb" {
  name               = "${var.resrc_prefix_nm}-mgmt-alb"
  load_balancer_type = "application"
  internal           = false
  subnets            = var.pub_sn_ids

  security_groups    = [ var.mgmt_sg_id ]

  // NOTE there is a bug in terraform - it can't remove the lb and the whole destroy fails
  enable_deletion_protection = false

  tags = {
    Name        = "${var.resrc_prefix_nm}-mgmt-alb"
    Environment = var.environment
  }
}

resource "aws_alb_listener" "mgmt-alb-listener443" {
  load_balancer_arn = aws_alb.mgmt-alb.arn
  port              = 443
  protocol          = "HTTPS"
  certificate_arn   = var.acm_arn
  depends_on        = [ aws_alb.mgmt-alb, var.jenkins-tg8088 ]

  default_action {
    target_group_arn = var.jenkins-tg8088.arn
    type             = "forward"
  }
}

resource "aws_alb_listener_rule" "mgmt-alb-listener443-gitlab-rule" {
  listener_arn        = aws_alb_listener.mgmt-alb-listener443.arn
  depends_on          = [ var.scm-tg80 ]

  action {
    target_group_arn  = var.scm-tg80.arn
    type              = "forward"
  }

  condition {
    host_header {
      values = [ var.hosts.gitlab ]
    }
  }
}

resource "aws_alb_listener_rule" "mgmt-alb-listener443-jenkins-rule" {
  listener_arn        = aws_alb_listener.mgmt-alb-listener443.arn
  depends_on          = [ var.jenkins-tg8088  ]

  action {
    target_group_arn  = var.jenkins-tg8088.arn
    type              = "forward"
  }

  condition {
    host_header {
      values = [ var.hosts.jenkins ]
    }
  }
}

resource "aws_alb_listener_rule" "mgmt-alb-listener443-nexus-rule" {
  listener_arn        = aws_alb_listener.mgmt-alb-listener443.arn
  depends_on          = [ var.nexus-tg8081  ]

  action {
    target_group_arn  = var.nexus-tg8081.arn
    type              = "forward"
  }

  condition {
    host_header {
      values = [ var.hosts.nexus ]
    }
  }
}

resource "aws_alb_listener_rule" "mgmt-alb-listener443-scouter-rule" {
  listener_arn        = aws_alb_listener.mgmt-alb-listener443.arn
  depends_on          = [ var.scouter-tg6100  ]

  action {
    target_group_arn  = var.scouter-tg6100.arn
    type              = "forward"
  }

  condition {
    host_header {
      values = [ var.hosts.scouter ]
    }
  }
}