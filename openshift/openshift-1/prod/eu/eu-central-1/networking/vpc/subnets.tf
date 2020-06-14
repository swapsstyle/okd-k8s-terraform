resource "aws_subnet" "openshift_public_sn" {
  count = length(var.availability_zones)
  vpc_id = aws_vpc.openshift_vpc.id
  cidr_block = cidrsubnet(var.cidr_block, 8, count.index)
  availability_zone = var.availability_zones[count.index]
  map_public_ip_on_launch = true

  tags = merge(
    local.common_tags,
    map(
      "Name", "${var.cluster_name}-public-subnet-${element(var.availability_zones, count.index)}",
      "kubernetes.io/cluster/${var.cluster_name}", "shared"
    )
  )
}

resource "aws_subnet" "openshift_private_sn" {
  count = length(var.availability_zones)
  vpc_id = aws_vpc.openshift_vpc.id

  cidr_block = cidrsubnet(var.cidr_block, 8, count.index + length(var.availability_zones))
  availability_zone = var.availability_zones[count.index]

  tags = merge(
    local.common_tags,
    map(
      "Name", "${var.cluster_name}-private-subnet-${element(var.availability_zones, count.index)}",
      "kubernetes.io/cluster/${var.cluster_name}", "shared"
    )
  )
}

resource "aws_eip" "openshift_nat_eip" {
  count = length(var.availability_zones)
  vpc = true

  tags = merge(
    local.common_tags,
    map(
      "Name", "${var.cluster_name}-elastic-ip-${element(var.availability_zones, count.index)}"
    )
  )
}

resource "aws_nat_gateway" "openshift_nat_gateway" {
  count = length(var.availability_zones)
  subnet_id = aws_subnet.openshift_public_sn.*.id[count.index]
  allocation_id = aws_eip.openshift_nat_eip.*.id[count.index]

  tags = merge(
    local.common_tags,
    map(
      "Name", "${var.cluster_name}-nat-gateway-${element(var.availability_zones, count.index)}"
    )
  )
}
