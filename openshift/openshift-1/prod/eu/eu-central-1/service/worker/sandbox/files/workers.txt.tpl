Add the following in makefile below comment #add-key-hostnames 

${add_key_hostname}

------------------------------------------------------------------------------
Add the following in makefile below comment #post-install-hostnames 

${post_install_hostname}

------------------------------------------------------------------------------
Add the following in inventory below comment #add-new-nodes

${worker_hostname}

------------------------------------------------------------------------------
Add the following in inventory file for openshift_node_groups variable to add the kubernetes node labels.

${openshift_node_groups}