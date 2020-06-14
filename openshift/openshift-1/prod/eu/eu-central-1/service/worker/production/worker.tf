
data "template_file" "workers" {

  template = "${file("${path.module}/files/workers.txt.tpl")}"
  vars = {

    worker_hostname = join("\n",
            formatlist(
              "%s %s",
              aws_instance.openshift_worker.*.private_dns,
              "openshift_node_group_name='node-config-${lower(var.environment)}'"
            )
        )
    
    add_key_hostname = join("\n",
            formatlist(
              "%s %s %s",
              "ssh -A centos@${data.terraform_remote_state.openshift_ansible.outputs.private_ip} 'ssh-keyscan -t rsa -H",
              aws_instance.openshift_worker.*.private_dns,
              ">> ~/.ssh/known_hosts'"
            )
        )

    post_install_hostname = join("\n",
            formatlist(
              "%s%s",
              "- cat ./scripts/post-install-node.sh | ssh -A centos@${data.terraform_remote_state.openshift_ansible.outputs.private_ip} ssh centos@",
              aws_instance.openshift_worker.*.private_dns
            )
        )
    
    openshift_node_groups = "{'name': 'node-config-${lower(var.environment)}', 'labels': ['node-role.kubernetes.io/compute=true', 'Environment=${var.environment}']}"
    
  }
}

resource "local_file" "workers" {
  content     = data.template_file.workers.rendered
  filename = "${path.module}/files/workers.txt"
  
}