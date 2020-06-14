
output "openshift_cluster_sg" {
  value = aws_security_group.openshift_cluster_sg.id
}

output "openshift_ansible_sg" {
  value = aws_security_group.openshift_ansible_sg.id
}

output "openshift_lb_sg" {
  value = aws_security_group.openshift_lb_sg.id
}
