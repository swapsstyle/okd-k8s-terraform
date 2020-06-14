resource "aws_route_table" "openshift_public_rt" {
  vpc_id = aws_vpc.openshift_vpc.id

  tags = merge(
    local.common_tags,
    map(
      "Name", "${var.cluster_name}-public-route-table"
    )
  )
}

resource "aws_route" "openshift_public_route" {
  route_table_id         = aws_route_table.openshift_public_rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.openshift_vpc_gw.id
}

resource "aws_route_table_association" "openshift_public_rta" {
  count = length(var.availability_zones)

  subnet_id      = aws_subnet.openshift_public_sn.*.id[count.index]
  route_table_id = aws_route_table.openshift_public_rt.id
}

resource "aws_route_table" "openshift_private_rt" {
  count  = length(var.availability_zones)
  vpc_id = aws_vpc.openshift_vpc.id

  tags = merge(
    local.common_tags,
    map(
      "Name", "${var.cluster_name}--private-route-table-${element(var.availability_zones, count.index)}"
    )
  )
}

resource "aws_route" "openshift_private_route" {
  count = length(var.availability_zones)

  route_table_id         = aws_route_table.openshift_private_rt.*.id[count.index]
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.openshift_nat_gateway.*.id[count.index]
}

resource "aws_route_table_association" "openshift_private_rta" {
  count = length(var.availability_zones)

  subnet_id      = aws_subnet.openshift_private_sn.*.id[count.index]
  route_table_id = aws_route_table.openshift_private_rt.*.id[count.index]
}
