resource "aws_elb" "openshift_master_elb" {

  name               = "${var.cluster_name}-master-elb"
  internal           = true
  subnets            = [ 
                        data.terraform_remote_state.openshift_vpc.outputs.openshift_private_sn_id_list.0,
                        data.terraform_remote_state.openshift_vpc.outputs.openshift_private_sn_id_list.1,
                        data.terraform_remote_state.openshift_vpc.outputs.openshift_private_sn_id_list.2
                        ] 

  listener {
    instance_port     = 8443
    instance_protocol = "tcp"
    lb_port           = 8443
    lb_protocol       = "tcp"
  }

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    target              = "tcp:8443"
    interval            = 30
  }

  instances            = [
                        data.aws_instance.openshift_cluster_master_1.id,
                        data.aws_instance.openshift_cluster_master_2.id,
                        data.aws_instance.openshift_cluster_master_3.id,
                          ]
  security_groups = [
    data.terraform_remote_state.openshift_security_group.outputs.openshift_cluster_sg
  ]
  cross_zone_load_balancing   = true
  idle_timeout                = 400
  connection_draining         = true
  connection_draining_timeout = 400

  tags = merge(
    local.common_tags,
    map(
      "Name", "${var.cluster_name}-master-elb"
    )
  )
}
    
resource "aws_elb" "openshift_infra_elb" {
  count            = length(data.aws_instances.openshift_cluster_infra.ids)
  name               =  "${var.cluster_name}-infra-elb"
  internal           = true
  subnets            =   [ 
                        data.terraform_remote_state.openshift_vpc.outputs.openshift_private_sn_id_list.0,
                        data.terraform_remote_state.openshift_vpc.outputs.openshift_private_sn_id_list.1,
                        data.terraform_remote_state.openshift_vpc.outputs.openshift_private_sn_id_list.2
                        ] 

  listener {
    instance_port     = 80
    instance_protocol = "tcp"
    lb_port           = 80
    lb_protocol       = "tcp"
  }

  listener {
    instance_port     = 443
    instance_protocol = "tcp"
    lb_port           = 443
    lb_protocol       = "tcp"
  }

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    target              = "tcp:80"
    interval            = 30
  }

  instances            = data.aws_instances.openshift_cluster_infra.ids
  security_groups = [
    data.terraform_remote_state.openshift_security_group.outputs.openshift_cluster_sg
  ]
  cross_zone_load_balancing   = true
  idle_timeout                = 400
  connection_draining         = true
  connection_draining_timeout = 400

  tags = merge(
    local.common_tags,
    map(
      "Name", "${var.cluster_name}-infra-elb"
    )
  )

} 
