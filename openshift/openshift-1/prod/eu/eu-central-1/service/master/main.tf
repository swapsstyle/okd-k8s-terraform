
resource "aws_instance" "openshift_master_1" {

  ami = "ami-04cf43aca3e6f3de3"
  instance_type        = var.instance_type
  iam_instance_profile = data.terraform_remote_state.openshift_iam.outputs.openshift_instance_profile
  subnet_id = data.terraform_remote_state.openshift_vpc.outputs.openshift_private_sn_id_list.0
  vpc_security_group_ids = [
    data.terraform_remote_state.openshift_security_group.outputs.openshift_cluster_sg
  ]
  root_block_device {
    volume_type = "gp2"
    volume_size = "100"
    delete_on_termination = true
  }
  associate_public_ip_address = false
  key_name = "${var.cluster_name}-key"

  tags = merge(
    local.common_tags,
    map(
      "Name", "${var.cluster_name}-cluster-master-1",
      "kubernetes.io/cluster/${var.cluster_name}", "owned",
      "node-role.kubernetes.io/master", "true"
    )
  )
}

resource "aws_instance" "openshift_master_2" {

  ami = "ami-04cf43aca3e6f3de3"
  instance_type        = var.instance_type
  iam_instance_profile = data.terraform_remote_state.openshift_iam.outputs.openshift_instance_profile
  subnet_id = data.terraform_remote_state.openshift_vpc.outputs.openshift_private_sn_id_list.1
  vpc_security_group_ids = [
    data.terraform_remote_state.openshift_security_group.outputs.openshift_cluster_sg
  ]
  root_block_device {
    volume_type = "gp2"
    volume_size = "100"
    delete_on_termination = true
  }
  associate_public_ip_address = false
  key_name = "${var.cluster_name}-key"

  tags = merge(
    local.common_tags,
    map(
      "Name", "${var.cluster_name}-cluster-master-2",
      "kubernetes.io/cluster/${var.cluster_name}", "owned",
      "node-role.kubernetes.io/master", "true"
    )
  )
}

resource "aws_instance" "openshift_master_3" {

  ami = "ami-04cf43aca3e6f3de3"
  instance_type        = var.instance_type
  iam_instance_profile = data.terraform_remote_state.openshift_iam.outputs.openshift_instance_profile
  subnet_id = data.terraform_remote_state.openshift_vpc.outputs.openshift_private_sn_id_list.2
  vpc_security_group_ids = [
    data.terraform_remote_state.openshift_security_group.outputs.openshift_cluster_sg
  ]
  root_block_device {
    volume_type = "gp2"
    volume_size = "100"
    delete_on_termination = true
  }
  associate_public_ip_address = false
  key_name = "${var.cluster_name}-key"

  tags = merge(
    local.common_tags,
    map(
      "Name", "${var.cluster_name}-cluster-master-3",
      "kubernetes.io/cluster/${var.cluster_name}", "owned",
      "node-role.kubernetes.io/master", "true"
    )
  )
}