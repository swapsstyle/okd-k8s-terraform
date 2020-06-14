
variable "environment" {
  default = "test"
}

variable "region" {
  default = "eu-central-1"
}

variable "cluster_name" {
  default = "openshift-1"
}

variable "whitelist_ips" {
  default = []
}

locals {
  common_tags = map(
  "Project", "okd",
  "Region", var.region,
  "Environment", var.environment,
  "Group", "${var.cluster_name}-sg",
  "Credits", "swapsstyle"
  )
}
