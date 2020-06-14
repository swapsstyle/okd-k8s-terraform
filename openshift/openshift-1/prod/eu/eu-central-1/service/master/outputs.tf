
output "master_1_private_dns" {
  value = aws_instance.openshift_master_1.private_dns
}

output "master_2_private_dns" {
  value = aws_instance.openshift_master_2.private_dns
}

output "master_3_private_dns" {
  value = aws_instance.openshift_master_3.private_dns
}
