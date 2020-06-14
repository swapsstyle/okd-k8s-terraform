variable "cidr_block" {
  description = "VPC cidr block. Example: 10.0.0.0/16"
  default = ""
}

variable "environment" {
  default = "test"
}

variable "region" {
  default = "eu-central-1"
}

variable "availability_zones" {
  default = [
    "eu-central-1a",
    "eu-central-1b",
    "eu-central-1c"
  ]
}

variable "cluster_name" {
  default = "openshift-1"
}

locals {
  common_tags = map(
  "Project", "okd",
  "Region", var.region,
  "Environment", var.environment,
  "Group", "${var.cluster_name}-vpc",
  "Credits", "swapsstyle"
  )
}
