
resource "aws_security_group" "openshift_cluster_sg" {

  name        = "${var.cluster_name}-cluster-sg"
  description = "Used for openshift internal instances"
  vpc_id      = data.terraform_remote_state.openshift_vpc.outputs.openshift_vpc_id
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [
      data.terraform_remote_state.openshift_vpc.outputs.openshift_vpc_cidr_block]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  lifecycle {
    create_before_destroy = true
  }

  tags = merge(
  local.common_tags,
  map(
  "Name", "${var.cluster_name}-internal-cluster-sg",
  "kubernetes.io/cluster/${var.cluster_name}", "owned"
  )
  )
}

resource "aws_security_group" "openshift_ansible_sg" {
  
  name        = "${var.cluster_name}-ansible-sg"
  description = "Used for ansible instance"
  vpc_id      = data.terraform_remote_state.openshift_vpc.outputs.openshift_vpc_id
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = var.whitelist_ips
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  lifecycle {
    create_before_destroy = true
  }

  tags = merge(
  local.common_tags,
  map(
  "Name", "${var.cluster_name}-ansible-sg"
  )
  )
}

resource "aws_security_group" "openshift_lb_sg" {
  
  name        = "${var.cluster_name}-lb-sg"
  description = "Used for lb loadbalancer"
  vpc_id      = data.terraform_remote_state.openshift_vpc.outputs.openshift_vpc_id
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = var.whitelist_ips
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  lifecycle {
    create_before_destroy = true
  }

  tags = merge(
  local.common_tags,
  map(
  "Name", "${var.cluster_name}-lb-sg"
  )
  )
}