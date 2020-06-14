
output "master_elb_dns" {
    value = aws_elb.openshift_master_elb.dns_name
}

output "master_external_alb_dns" {
    value = aws_alb.openshift_ext_alb.dns_name
}

output "infra_elb_dns" {
    value = aws_elb.openshift_infra_elb.0.dns_name
}

output "master_elb_zone_id" {
    value = aws_elb.openshift_master_elb.zone_id
}

output "master_external_zone_id" {
    value = aws_alb.openshift_ext_alb.zone_id
}

output "infra_elb_zone_id" {
    value = aws_elb.openshift_infra_elb.0.zone_id
}
