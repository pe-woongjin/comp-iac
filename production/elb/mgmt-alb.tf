resource "aws_alb" "mgmt-alb" {
  name               = "${var.tag_name}-mgmt-alb"
  load_balancer_type = "application"
  internal           = false
  subnets            = var.pub_sn_ids

  security_groups    = [ var.mgmt_sg_id ]

  // NOTE there is a bug in terraform - it can't remove the lb and the whole destroy fails
  enable_deletion_protection = false

  tags = {
    Name        = "${var.tag_name}-mgmt-alb"
    Environment = var.environment
  }
}

resource "aws_alb_target_group" "scm-tg80"  {
  name        = "${var.tag_name}-scm-tg80"
  protocol    = "HTTP"
  port        = 80
  target_type = "instance"
  vpc_id      = var.vpc_id
  depends_on  = [ aws_alb.mgmt-alb ]

  tags = {
    Name        = "${var.tag_name}-scm-tg80"
    Environment = var.environment
  }
}

resource "aws_alb_target_group" "jenkins-tg8088"  {
  name        = "${var.tag_name}-jenkins-tg8088"
  protocol    = "HTTP"
  port        = 8088
  target_type = "instance"
  vpc_id      = var.vpc_id
  depends_on  = [ aws_alb.mgmt-alb ]

  tags = {
    Name        = "${var.tag_name}-jenkins-tg8088"
    Environment = var.environment
  }
}


resource "aws_alb_target_group" "nexus-tg8081"  {
  name        = "${var.tag_name}-nexus-tg8081"
  protocol    = "HTTP"
  port        = 8081
  target_type = "instance"
  vpc_id      = var.vpc_id
  depends_on  = [ aws_alb.mgmt-alb ]

  tags = {
    Name        = "${var.tag_name}-nexus-tg8081"
    Environment = var.environment
  }
}

resource "aws_alb_target_group" "scouter-tg6100"  {
  name        = "${var.tag_name}-scouter-tg6100"
  protocol    = "HTTP"
  port        = 6100
  target_type = "instance"
  vpc_id      = var.vpc_id
  depends_on  = [ aws_alb.mgmt-alb ]

  tags = {
    Name        = "${var.tag_name}-scouter-tg8081"
    Environment = var.environment
  }
}

resource "aws_alb_listener" "mgmt-alb-listener443" {
  load_balancer_arn = aws_alb.mgmt-alb.arn
  port              = 443
  protocol          = "HTTPS"
  certificate_arn   = var.acm_arn
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
      values = [ var.host.gitlab ]
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
      values = [ var.host.jenkins ]
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
      values = [ var.host.nexus ]
    }
  }
}

resource "aws_alb_listener_rule" "mgmt-alb-listener443-scouter-rule" {
  listener_arn        = aws_alb_listener.mgmt-alb-listener443.arn
  depends_on          = [ aws_alb_target_group.scouter-tg6100  ]

  action {
    target_group_arn  = aws_alb_target_group.scouter-tg6100.arn
    type              = "forward"
  }

  condition {
    host_header {
      values = [ var.host.scouter ]
    }
  }
}