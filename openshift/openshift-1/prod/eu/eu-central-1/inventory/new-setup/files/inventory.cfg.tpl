[OSEv3:children]
masters
etcd
nodes

[OSEv3:vars]
ansible_ssh_user=centos

ansible_become=true

openshift_deployment_type=origin
openshift_release=v3.11
openshift_metrics_install_metrics=true
openshift_logging_install_logging=true
openshift_console_install=true
openshift_install_examples=false
openshift_additional_repos=[{'id': 'centos-okd-ci', 'name': 'centos-okd-ci', 'baseurl' :'https://rpms.svc.ci.openshift.org/openshift-origin-v3.11', 'gpgcheck' :'0', 'enabled' :'1'}]
openshift_disable_check=docker_image_availability,docker_storage,disk_availability,memory_availability
openshift_hosted_registry_selector='node-role.kubernetes.io/infra=true'
openshift_logging_es_ops_nodeselector={"node-role.kubernetes.io/infra":"true"}
openshift_logging_es_nodeselector={"node-role.kubernetes.io/infra":"true"}

openshift_node_groups=[{'name': 'node-config-master', 'labels': ['node-role.kubernetes.io/master=true']}, {'name': 'node-config-infra', 'labels': ['node-role.kubernetes.io/infra=true']}, {'name': 'node-config-compute', 'labels': ['node-role.kubernetes.io/compute=true']}, {'name': 'node-config-production', 'labels': ['node-role.kubernetes.io/compute=true', 'environment=production']}, {'name': 'node-config-sandbox', 'labels': ['node-role.kubernetes.io/compute=true', 'environment=sandbox']}]

openshift_master_default_subdomain=${master_subdomain}
openshift_public_hostname=${public_hostname}
openshift_master_cluster_hostname=${master_hostname}

openshift_master_identity_providers=[{'name': 'htpasswd_auth', 'login': 'true', 'challenge': 'true', 'kind': 'HTPasswdPasswordIdentityProvider'}]

openshift_cloudprovider_kind=aws

openshift_clusterid=${cluster_id}

[masters]
${master1_hostname}
${master2_hostname}
${master3_hostname}

[etcd]
${master1_hostname}
${master2_hostname}
${master3_hostname}

[nodes]
${master1_hostname} openshift_node_group_name='node-config-master'
${master2_hostname} openshift_node_group_name='node-config-master'
${master3_hostname} openshift_node_group_name='node-config-master'
${infra_hostname}
${production_worker_hostname}
${sandbox_worker_hostname}
