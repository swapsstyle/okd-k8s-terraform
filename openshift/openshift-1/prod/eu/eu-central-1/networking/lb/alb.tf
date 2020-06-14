resource "aws_alb" "openshift_ext_alb" {  
  name            = "${var.cluster_name}-master-ext-alb"  
  subnets            = [ 
                        data.terraform_remote_state.openshift_vpc.outputs.openshift_private_sn_id_list.0,
                        data.terraform_remote_state.openshift_vpc.outputs.openshift_private_sn_id_list.1,
                        data.terraform_remote_state.openshift_vpc.outputs.openshift_private_sn_id_list.2
                        ] 
  security_groups = [
    data.terraform_remote_state.openshift_security_group.outputs.openshift_lb_sg,
    data.terraform_remote_state.openshift_security_group.outputs.openshift_cluster_sg
  ]
  internal        = false 
  idle_timeout    = "60"
  tags = merge(
    local.common_tags,
    map(
      "Name", "${var.cluster_name}-master-ext-alb"
    )
  )    
}

resource "aws_alb_listener" "openshift_ext_alb_listener" {  
  load_balancer_arn = aws_alb.openshift_ext_alb.arn
  port              = "8443"  
  protocol          = "HTTP"
  default_action {    
    target_group_arn = aws_alb_target_group.openshift_ext_alb_target_group.arn
    type             = "forward"  
  }
}

resource "aws_alb_target_group" "openshift_ext_alb_target_group" {  
  name          = "${var.cluster_name}-master-ext-alb-tg"  
  port          = "8443"  
  protocol      = "HTTP"
  target_type   = "instance"  
  vpc_id        = data.terraform_remote_state.openshift_vpc.outputs.openshift_vpc_id   
  tags = merge(
    local.common_tags,
    map(
      "Name", "${var.cluster_name}-master-ext-alb-tg"
    )
  )   
  stickiness {    
    type            = "lb_cookie"    
    cookie_duration = 5040    
    enabled         = true  
  }

  deregistration_delay  = "300"
  health_check {
    protocol            = "HTTP"    
    healthy_threshold   = 5    
    unhealthy_threshold = 2    
    timeout             = 5    
    interval            = 30    
    path                = "/"
    port                = "8443"  
  }
}

resource "aws_alb_target_group_attachment" "openshift_ext_alb_target_group_attachment_master_1" {
  target_group_arn = aws_alb_target_group.openshift_ext_alb_target_group.arn
  target_id        = data.aws_instance.openshift_cluster_master_1.id
}

resource "aws_alb_target_group_attachment" "openshift_ext_alb_target_group_attachment_master_2" {
  target_group_arn = "${aws_alb_target_group.openshift_ext_alb_target_group.arn}"
  target_id        = data.aws_instance.openshift_cluster_master_2.id
}

resource "aws_alb_target_group_attachment" "openshift_ext_alb_target_group_attachment_master_3" {
  target_group_arn = "${aws_alb_target_group.openshift_ext_alb_target_group.arn}"
  target_id        = data.aws_instance.openshift_cluster_master_3.id
}
