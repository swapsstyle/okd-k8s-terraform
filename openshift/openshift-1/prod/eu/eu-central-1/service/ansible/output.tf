
output "private_ip" {
  value = aws_instance.openshift_ansible.private_ip
}

output "public_ip" {
  value = aws_instance.openshift_ansible.public_ip
}
