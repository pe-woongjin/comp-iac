output "pub_sn_ids" {
  value = aws_subnet.pub-sn.*.id
}

output "mgmt_sg_id" {
  value = aws_security_group.mgmt-alb-sg.id
}