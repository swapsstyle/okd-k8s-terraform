terraform {
  required_version = ">= 0.12.23"

  backend "s3" {
    bucket  = "<bucket-name>"
    key     = "openshift/openshift-1/prod/eu/eu-central-1/networking/dns-records/dns-records.tfstate"
    region  = "eu-central-1"
    encrypt = "true"

    dynamodb_table = "<table-name>"
  }
}
