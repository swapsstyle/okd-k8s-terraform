resource "aws_route53_record" "openshift_master_external_alb_record" {
  zone_id = aws_route53_zone.openshift_public_zone.zone_id
  name    = var.public_hostname
  type    = "A"

  alias {
    name                   = data.terraform_remote_state.openshift_lb.outputs.master_external_alb_dns
    zone_id                = data.terraform_remote_state.openshift_lb.outputs.master_external_zone_id
    evaluate_target_health = true
  }
}

resource "aws_route53_record" "openshift_master_internal_elb_record" {
  zone_id = aws_route53_zone.openshift_private_zone.zone_id
  name    = var.master_hostname
  type    = "A"

  alias {
    name                   = data.terraform_remote_state.openshift_lb.outputs.master_elb_dns
    zone_id                = data.terraform_remote_state.openshift_lb.outputs.master_elb_zone_id
    evaluate_target_health = true
  }
}

resource "aws_route53_record" "openshift_infra_internal_elb_record" {
  zone_id = aws_route53_zone.openshift_private_zone.zone_id
  name    = var.master_subdomain
  type    = "A"

  alias {
    name                   = data.terraform_remote_state.openshift_lb.outputs.infra_elb_dns
    zone_id                = data.terraform_remote_state.openshift_lb.outputs.infra_elb_zone_id
    evaluate_target_health = true
  }
}

