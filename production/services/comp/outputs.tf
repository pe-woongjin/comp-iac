output "pub_sn_ids" {
  value = aws_subnet.pub-sn.*.id
}

output "mgmt_sg_id" {
  value = aws_security_group.mgmt-alb-sg.id
}

output "gitlab-tg80" {
  value = aws_lb_target_group.gitlab-tg80
}

output "gitlab-ssh-tg22" {
  value = aws_lb_target_group.gitlab-ssh-tg22
}

output "scm-tg80" {
  value = aws_alb_target_group.scm-tg80
}

output "jenkins-tg8088" {
  value = aws_alb_target_group.jenkins-tg8088
}

output "nexus-tg8081" {
  value = aws_alb_target_group.nexus-tg8081
}

output "scouter-tg6100" {
  value = aws_alb_target_group.scouter-tg6100
}