
output "private_dns" {
  value = aws_instance.openshift_infra.*.private_dns
}
