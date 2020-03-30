resource "aws_lb_target_group" "gitlab-tg80"  {
  name        = "${var.resrc_prefix_nm}-gitlab-tg80"
  protocol    = "TCP"
  port        = 80
  target_type = "instance"
  vpc_id      = var.vpc_id

  tags = {
    Name        = "${var.resrc_prefix_nm}-gitlab-tg80"
    Environment = var.environment
  }
}

resource "aws_lb_target_group" "gitlab-ssh-tg22"  {
  name        = "${var.resrc_prefix_nm}-gitlab-ssh-tg22"
  protocol    = "TCP"
  port        = 22
  target_type = "instance"
  vpc_id      = var.vpc_id

  tags = {
    Name        = "${var.resrc_prefix_nm}-gitlab-ssh-tg22"
    Environment = var.environment
  }
}

resource "aws_alb_target_group" "scm-tg80"  {
  name        = "${var.resrc_prefix_nm}-scm-tg80"
  protocol    = "HTTP"
  port        = 80
  target_type = "instance"
  vpc_id      = var.vpc_id

  tags = {
    Name        = "${var.resrc_prefix_nm}-scm-tg80"
    Environment = var.environment
  }
}

resource "aws_alb_target_group" "jenkins-tg8088"  {
  name        = "${var.resrc_prefix_nm}-jenkins-tg8088"
  protocol    = "HTTP"
  port        = 8088
  target_type = "instance"
  vpc_id      = var.vpc_id

  tags = {
    Name        = "${var.resrc_prefix_nm}-jenkins-tg8088"
    Environment = var.environment
  }
}

resource "aws_alb_target_group" "nexus-tg8081"  {
  name        = "${var.resrc_prefix_nm}-nexus-tg8081"
  protocol    = "HTTP"
  port        = 8081
  target_type = "instance"
  vpc_id      = var.vpc_id

  tags = {
    Name        = "${var.resrc_prefix_nm}-nexus-tg8081"
    Environment = var.environment
  }
}

resource "aws_alb_target_group" "scouter-tg6100"  {
  name        = "${var.resrc_prefix_nm}-scouter-tg6100"
  protocol    = "HTTP"
  port        = 6100
  target_type = "instance"
  vpc_id      = var.vpc_id

  tags = {
    Name        = "${var.resrc_prefix_nm}-scouter-tg8081"
    Environment = var.environment
  }
}