

data "terraform_remote_state" "openshift_iam" {
  backend = "s3"
  workspace = terraform.workspace

  config = {
    bucket = "<bucket-name>"
    key = "openshift/openshift-1/prod/eu/eu-central-1/iam/iam.tfstate"
    region = var.region
  }
}

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

data "template_file" "sysprep-ansible" {
  template = "${file("./helper_scripts/sysprep-ansible.sh")}"
}
