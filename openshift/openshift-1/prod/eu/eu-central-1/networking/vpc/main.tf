resource "aws_vpc" "openshift_vpc" {
  cidr_block = var.cidr_block
  enable_dns_support = true
  enable_dns_hostnames = true

  tags = merge(
    local.common_tags,
    map(
      "Name", "${var.cluster_name}-vpc",
      "kubernetes.io/cluster/${var.cluster_name}", "shared"
    )
  )
}

resource "aws_internet_gateway" "openshift_vpc_gw" {
  vpc_id = aws_vpc.openshift_vpc.id

  tags = merge(
    local.common_tags,
    map(
      "Name", "${var.cluster_name}-vpc-igw"
    )
  )
}

