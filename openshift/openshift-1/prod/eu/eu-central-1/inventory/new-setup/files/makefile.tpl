# Installs OpenShift on the cluster.
openshift-cluster:
	# Add our identity for ssh, add the host key to avoid having to accept the
	# the host key manually. Also add the identity of each node to the ansible.	
	ssh-add -k ~/.ssh/id_rsa
	ssh-keyscan -t rsa -H ${ansible_host} >> ~/.ssh/known_hosts
	ssh -A centos@${ansible_host} "ssh-keyscan -t rsa -H ${master1_hostname} >> ~/.ssh/known_hosts"
${add_key_infra_hostname}
${add_key_production_worker_hostname}
${add_key_sandbox_worker_hostname}

	# Copy our inventory to the master and run the install script.
	scp ./files/inventory.cfg centos@${ansible_host}:~/
	scp ./files/prepare.yml centos@${ansible_host}:~/
	cat ./scripts/install-cluster-from-ansible.sh | ssh -o StrictHostKeyChecking=no -A centos@${ansible_host}

	# Now the installer is done, run the postinstall steps on each host.
	# connection termination.
	- cat ./scripts/post-install-master.sh | ssh -A centos@${ansible_host} ssh centos@${master1_hostname}
${post_install_infra_hostname}
${post_install_production_worker_hostname}
${post_install_sandbox_worker_hostname}
