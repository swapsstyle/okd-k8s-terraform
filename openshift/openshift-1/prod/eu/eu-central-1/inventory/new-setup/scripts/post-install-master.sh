#!/usr/bin/env bash

# Note: This script runs after the ansible install, use it to make configuration
# changes which would otherwise be overwritten by ansible.
echo "------------------------------------------------------------------------------------"

sudo su

# Create an htpasswd file, we'll use htpasswd auth for OpenShift.
htpasswd -cb /etc/origin/master/htpasswd <provide-username> <provide-password>
oc create clusterrolebinding <provide-cluster-role-binding-name> --clusterrole=cluster-admin --user=<provide-username> --group=system:cluster-admins

cat <<EOF > /etc/sysctl.d/99-elasticsearch.conf
vm.max_map_count = 262144
EOF
sysctl vm.max_map_count=262144

# Update the docker config to allow OpenShift's local insecure registry. Also
# use json-file for logging, so our Splunk forwarder can eat the container logs.
# json-file for logging
sed -i '/OPTIONS=.*/c\OPTIONS="--selinux-enabled --insecure-registry 172.30.0.0/16 --log-driver=json-file --log-opt max-size=1M --log-opt max-file=3"' /etc/sysconfig/docker
echo "Docker configuration updated..."

# It seems that with OKD 3.10, systemctl restart docker will hang. So just reboot.
echo "Restarting host..."
shutdown -r now "restarting post docker configuration"
echo "------------------------------------------------------------------------------------"
