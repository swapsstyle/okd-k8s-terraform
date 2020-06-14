
data "template_file" "inventory" {

  template = "${file("${path.module}/files/inventory.cfg.tpl")}"
  vars = {
    cluster_id = var.cluster_name
    public_hostname = var.public_hostname
    master_subdomain = var.master_subdomain
    master_hostname = var.master_hostname
    master1_hostname = data.terraform_remote_state.openshift_master.outputs.master_1_private_dns
    master2_hostname = data.terraform_remote_state.openshift_master.outputs.master_2_private_dns
    master3_hostname = data.terraform_remote_state.openshift_master.outputs.master_3_private_dns
    
    infra_hostname = join("\n",
            formatlist(
              "%s %s",
              data.terraform_remote_state.openshift_infra.outputs.private_dns,
              "openshift_node_group_name='node-config-infra'"
            )
        )
    production_worker_hostname = join("\n",
            formatlist(
              "%s %s",
              data.terraform_remote_state.openshift_production_worker.outputs.private_dns,
              "openshift_node_group_name='node-config-production'"
            )
        )
    sandbox_worker_hostname = join("\n",
            formatlist(
              "%s %s",
              data.terraform_remote_state.openshift_sandbox_worker.outputs.private_dns,
              "openshift_node_group_name='node-config-sandbox'"
            )
        )
  }
}

resource "local_file" "inventory" {
  content     = data.template_file.inventory.rendered
  filename = "${path.module}/files/inventory.cfg"
  
}


data "template_file" "makefile" {

  template = "${file("${path.module}/files/makefile.tpl")}"
  vars = {
    ansible_host = data.terraform_remote_state.openshift_ansible.outputs.private_ip
    master1_hostname = data.terraform_remote_state.openshift_master.outputs.master_1_private_dns
    master2_hostname = data.terraform_remote_state.openshift_master.outputs.master_2_private_dns
    master3_hostname = data.terraform_remote_state.openshift_master.outputs.master_3_private_dns    

    add_key_infra_hostname = join("\n",
            formatlist(
              "%s %s %s",
              "\tssh -A centos@${data.terraform_remote_state.openshift_ansible.outputs.private_ip} 'ssh-keyscan -t rsa -H",
              data.terraform_remote_state.openshift_infra.outputs.private_dns,
              ">> ~/.ssh/known_hosts'"
            )
        )

    add_key_production_worker_hostname = join("\n",
            formatlist(
              "%s %s %s",
              "\tssh -A centos@${data.terraform_remote_state.openshift_ansible.outputs.private_ip} 'ssh-keyscan -t rsa -H",
              data.terraform_remote_state.openshift_production_worker.outputs.private_dns,
              ">> ~/.ssh/known_hosts'"
            )
        )
    add_key_sandbox_worker_hostname = join("\n",
            formatlist(
              "%s %s %s",
              "\tssh -A centos@${data.terraform_remote_state.openshift_ansible.outputs.private_ip} 'ssh-keyscan -t rsa -H",
              data.terraform_remote_state.openshift_sandbox_worker.outputs.private_dns,
              ">> ~/.ssh/known_hosts'"
            )
        )

    post_install_infra_hostname = join("\n",
            formatlist(
              "%s%s",
              "\t- cat ./scripts/post-install-node.sh | ssh -A centos@${data.terraform_remote_state.openshift_ansible.outputs.private_ip} ssh centos@",
              data.terraform_remote_state.openshift_infra.outputs.private_dns
            )
        )
        
    post_install_production_worker_hostname = join("\n",
            formatlist(
              "%s%s",
              "\t- cat ./scripts/post-install-node.sh | ssh -A centos@${data.terraform_remote_state.openshift_ansible.outputs.private_ip} ssh centos@",
              data.terraform_remote_state.openshift_production_worker.outputs.private_dns
            )
        )
    post_install_sandbox_worker_hostname = join("\n",
            formatlist(
              "%s%s",
              "\t- cat ./scripts/post-install-node.sh | ssh -A centos@${data.terraform_remote_state.openshift_ansible.outputs.private_ip} ssh centos@",
              data.terraform_remote_state.openshift_sandbox_worker.outputs.private_dns
            )
        )
  }
}

resource "local_file" "makefile" {
  content     = data.template_file.makefile.rendered
  filename = "${path.module}/makefile"
  
}

