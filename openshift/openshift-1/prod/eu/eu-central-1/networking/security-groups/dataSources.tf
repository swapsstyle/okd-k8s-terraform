data "terraform_remote_state" "openshift_vpc" {
  backend = "s3"
  workspace = terraform.workspace

  config = {
    bucket = "<bucket-name>"
    key = "openshift/openshift-1/prod/eu/eu-central-1/networking/vpc/vpc.tfstate"
    region = var.region
  }
}