
resource "aws_instance" "openshift_infra" {

  count = var.instance_count
  ami = "ami-04cf43aca3e6f3de3"
  instance_type        = var.instance_type
  iam_instance_profile = data.terraform_remote_state.openshift_iam.outputs.openshift_instance_profile
  associate_public_ip_address = false
  subnet_id = element(data.terraform_remote_state.openshift_vpc.outputs.openshift_private_sn_id_list, count.index)
  vpc_security_group_ids = [
    data.terraform_remote_state.openshift_security_group.outputs.openshift_cluster_sg
  ]
  root_block_device {
    volume_type = "gp2"
    volume_size = "100"
    delete_on_termination = true
  }
  key_name = "${var.cluster_name}-key"

  tags = merge(
    local.common_tags,
    map(
      "Name", "${var.cluster_name}-cluster-infra-${count.index + 1}",
      "kubernetes.io/cluster/${var.cluster_name}", "owned",
      "node-role.kubernetes.io/infra", "true"
    )
  )
}