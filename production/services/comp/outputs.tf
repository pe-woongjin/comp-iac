output "pri_rt_ids" {
  value = aws_route_table.pri-rt.*.id
}