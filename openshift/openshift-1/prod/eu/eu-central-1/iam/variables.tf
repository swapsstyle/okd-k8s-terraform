variable "cluster_name" {
  default = "openshift-1"
}

locals {
  common_tags = map(
  "Project", "okd",
  "Region", "global",
  "Environment", var.environment,
  "Group", "${var.cluster_name}-iam",
  "Credits", "swapsstyle"
  )
}

variable "region" {
  default = "eu-central-1"
}

variable "environment" {
  default = "test"
}
