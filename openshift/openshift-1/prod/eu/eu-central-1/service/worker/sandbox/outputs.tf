
output "private_dns" {
  value = aws_instance.openshift_worker.*.private_dns
}

