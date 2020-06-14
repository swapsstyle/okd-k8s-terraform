
variable "environment" {
  default = "test"
}

variable "region" {
  default = "eu-central-1"
}

variable "cluster_name" {
  default = "openshift-1"
}
locals {
  common_tags = map(
  "Project", "okd",
  "Region", var.region,
  "Environment", var.environment,
  "Group", "${var.cluster_name}-zones",
  "Credits", "swapsstyle"
  )
}

variable "public_hostname" {
  default = ""
}

variable "master_subdomain" {
 default = "" 
}

variable "master_hostname" {
  default = ""
}

variable "public_zone" {
  default = ""
}

variable "private_zone" {
  default = ""
}