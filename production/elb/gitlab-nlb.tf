resource "aws_lb" "gitlab-nlb" {
  name               = "${var.tag_name}-gitlab-nlb"
  internal           = false
  load_balancer_type = "network"
  subnets            = var.pub_sn_ids

  enable_cross_zone_load_balancing = true

  // NOTE there is a bug in terraform - it can't remove the lb and the whole destroy fails
  enable_deletion_protection = false

  tags = {
    Name        = "${var.tag_name}-gitlab-nlb"
    Environment = var.environment
  }
}

resource "aws_lb_target_group" "gitlab-tg80"  {
  name        = "${var.tag_name}-gitlab-tg80"
  protocol    = "TCP"
  port        = 80
  target_type = "instance"
  vpc_id      = var.vpc_id
  depends_on  = [ aws_lb.gitlab-nlb ]

  tags = {
    Name        = "${var.tag_name}-gitlab-tg80"
    Environment = var.environment
  }
}

resource "aws_lb_target_group" "gitlab-ssh-tg22"  {
  name        = "${var.tag_name}-gitlab-ssh-tg22"
  protocol    = "TCP"
  port        = 22
  target_type = "instance"
  vpc_id      = var.vpc_id
  depends_on  = [ aws_lb.gitlab-nlb ]

  tags = {
    Name        = "${var.tag_name}-gitlab-ssh-tg22"
    Environment = var.environment
  }
}

resource "aws_lb_listener" "gitlab-nlb-listener22" {
  load_balancer_arn = aws_lb.gitlab-nlb.arn
  protocol          = "TCP"
  port              = 22
  depends_on        = [ aws_lb.gitlab-nlb, aws_lb_target_group.gitlab-ssh-tg22 ]

  default_action {
    target_group_arn = aws_lb_target_group.gitlab-ssh-tg22.arn
    type             = "forward"
  }
}

resource "aws_lb_listener" "gitlab-nlb-listener80" {
  load_balancer_arn = aws_lb.gitlab-nlb.arn
  protocol          = "TCP"
  port              = 80
  depends_on        = [ aws_lb.gitlab-nlb, aws_lb_target_group.gitlab-tg80 ]

  default_action {
    target_group_arn = aws_lb_target_group.gitlab-tg80.arn
    type             = "forward"
  }
}

resource "aws_lb_listener" "gitlab-nlb-listener443" {
  load_balancer_arn = aws_lb.gitlab-nlb.arn
  protocol          = "TLS"
  port              = 443
  certificate_arn   = var.acm_arn
  depends_on        = [ aws_lb.gitlab-nlb, aws_lb_target_group.gitlab-tg80 ]

  default_action {
    target_group_arn = aws_lb_target_group.gitlab-tg80.arn
    type             = "forward"
  }
}