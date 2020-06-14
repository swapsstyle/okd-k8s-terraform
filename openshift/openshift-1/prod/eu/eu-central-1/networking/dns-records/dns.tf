
resource "aws_route53_zone" "openshift_public_zone" {
  name = var.public_zone

  tags = merge(
  local.common_tags,
  map(
  "Name", var.public_zone,
  )
  )
}

resource "aws_route53_zone" "openshift_private_zone" {
  name = var.private_zone

  vpc {
    vpc_id = data.terraform_remote_state.openshift_vpc.outputs.openshift_vpc_id
  }

  tags = merge(
  local.common_tags,
  map(
  "Name", var.private_zone,
  )
  )
}
