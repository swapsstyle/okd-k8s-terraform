output "openshift_vpc_id" {
  value = aws_vpc.openshift_vpc.id
}

output "openshift_vpc_cidr_block" {
  value = aws_vpc.openshift_vpc.cidr_block
}

output "openshift_public_sn_id_list" {
  value = aws_subnet.openshift_public_sn.*.id
}

output "openshift_public_sn_cidr_block" {
  value = aws_subnet.openshift_public_sn.*.cidr_block
}

output "openshift_private_sn_id_list" {
  value = aws_subnet.openshift_private_sn.*.id
}

output "openshift_private_sn_cidr_block" {
  value = aws_subnet.openshift_private_sn.*.cidr_block
}

output "openshift_nat_eip_id_list" {
  value = aws_eip.openshift_nat_eip.*.id
}