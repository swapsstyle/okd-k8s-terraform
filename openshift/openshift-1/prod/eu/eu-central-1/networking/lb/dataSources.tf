data "terraform_remote_state" "openshift_vpc" {
  backend = "s3"
  workspace = terraform.workspace

  config = {
    bucket = "<bucket-name>"
    key = "openshift/openshift-1/prod/eu/eu-central-1/networking/vpc/vpc.tfstate"
    region = var.region
  }
}

data "terraform_remote_state" "openshift_security_group" {
  backend = "s3"
  workspace = terraform.workspace

  config = {
    bucket = "<bucket-name>"
    key = "openshift/openshift-1/prod/eu/eu-central-1/networking/security-group/security-group.tfstate"
    region = var.region
  }
}

data "aws_instance" "openshift_cluster_master_1" {
  instance_tags = {
    Name = "${var.cluster_name}-cluster-master-1"
  }

  filter {
    name = "tag:Name"
    values = ["${var.cluster_name}-cluster-master-1"]
  }
}

data "aws_instance" "openshift_cluster_master_2" {
  instance_tags = {
    Name = "${var.cluster_name}-cluster-master-2"
  }

  filter {
    name = "tag:Name"
    values = ["${var.cluster_name}-cluster-master-2"]
  }
}

data "aws_instance" "openshift_cluster_master_3" {
  instance_tags = {
    Name = "${var.cluster_name}-cluster-master-3"
  }

  filter {
    name = "tag:Name"
    values = ["${var.cluster_name}-cluster-master-3"]
  }
}

data "aws_instances" "openshift_cluster_infra" {
  instance_tags = {
    Group = "${var.cluster_name}-cluster-infra"
  }

  filter {
    name = "tag:Group"
    values = ["${var.cluster_name}-cluster-infra"]
  }
}
