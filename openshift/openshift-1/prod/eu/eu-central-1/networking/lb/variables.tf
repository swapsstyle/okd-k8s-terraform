variable "region" {
  default = "eu-central-1"
}

variable "environment" {
  default = "test"
}

variable "cluster_name" {
  default = "openshift-1"
}

locals {
  common_tags = map(
  "Project", "okd",
  "Region", var.region,
  "Environment", var.environment,
  "Group", "${var.cluster_name}-lb",
  "Credits", "swapsstyle"
  )
}

variable "availability_zones" {
  default = [
    "eu-central-1a",
    "eu-central-1b",
    "eu-central-1c"
  ]
}