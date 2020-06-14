
variable "environment" {
  default = "sandbox"
}

variable "region" {
  default = "eu-central-1"
}

variable "instance_count" {
  default = ""
}

variable "instance_type" {
  default = ""
}

variable "cluster_name" {
  default = "openshift-1"
}

locals {
  common_tags = map(
  "Project", "okd",
  "Region", var.region,
  "Environment", var.environment,
  "Group", "${var.cluster_name}-cluster-${var.environment}-worker",
  "Credits", "swapsstyle"
  )
}
