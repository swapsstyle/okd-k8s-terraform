
data "terraform_remote_state" "openshift_master" {
  backend = "s3"
  workspace = terraform.workspace

  config = {
    bucket = "<bucket-name>"
    key     = "openshift/openshift-1/prod/eu/eu-central-1/service/master/master.tfstate"
    region = var.region
  }
}

data "terraform_remote_state" "openshift_infra" {
  backend = "s3"
  workspace = terraform.workspace

  config = {
    bucket = "<bucket-name>"
    key     = "openshift/openshift-1/prod/eu/eu-central-1/service/infra/infra.tfstate"
    region = var.region
  }
}

data "terraform_remote_state" "openshift_ansible" {
  backend = "s3"
  workspace = terraform.workspace

  config = {
    bucket = "<bucket-name>"
    key     = "openshift/openshift-1/prod/eu/eu-central-1/service/ansible/ansible.tfstate"
    region = var.region
  }
}

data "terraform_remote_state" "openshift_production_worker" {
  backend = "s3"
  workspace = terraform.workspace

  config = {
    bucket = "<bucket-name>"
    key     = "openshift/openshift-1/prod/eu/eu-central-1/service/worker/production/production.tfstate"
    region = var.region
  }
}

data "terraform_remote_state" "openshift_sandbox_worker" {
  backend = "s3"
  workspace = terraform.workspace

  config = {
    bucket = "<bucket-name>"
    key     = "openshift/openshift-1/prod/eu/eu-central-1/service/worker/sandbox/sandbox.tfstate"
    region = var.region
  }
}
