
resource "aws_instance" "openshift_ansible" {

  ami = "ami-04cf43aca3e6f3de3"
  instance_type        = var.instance_type
  iam_instance_profile = data.terraform_remote_state.openshift_iam.outputs.openshift_instance_profile
  subnet_id            = data.terraform_remote_state.openshift_vpc.outputs.openshift_public_sn_id_list.0
  vpc_security_group_ids = [
    data.terraform_remote_state.openshift_security_group.outputs.openshift_ansible_sg
  ]
  root_block_device {
    volume_type = "gp2"
    volume_size = "100"
    delete_on_termination = true
  }
  associate_public_ip_address = true
  key_name = "${var.cluster_name}-key"
  user_data = data.template_file.sysprep-ansible.rendered

  tags = merge(
    local.common_tags,
    map(
      "Name", "${var.cluster_name}-cluster-ansible"
    )
  )
}
