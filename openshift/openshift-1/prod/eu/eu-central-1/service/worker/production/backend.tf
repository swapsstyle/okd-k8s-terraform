
terraform {
  required_version = ">= 0.12.23"

  backend "s3" {
    bucket  = "<bucket-name>"
    key     = "openshift/openshift-1/prod/eu/eu-central-1/service/worker/production/production.tfstate"
    region  = "eu-central-1"
    encrypt = "true"

    dynamodb_table = "<table-name>"
  }
}
