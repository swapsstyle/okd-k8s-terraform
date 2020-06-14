#!/usr/bin/env bash
set -x

# Elevate privileges, retaining the environment.
sudo -E su

# Install dev tools.
yum install -y "@Development Tools" python2-pip openssl-devel python-devel gcc libffi-devel

# Get the OKD 3.11 installer.
pip install -I ansible==2.6.5
pip install passlib --user
git clone -b release-3.11 https://github.com/openshift/openshift-ansible

# Run the playbook.
ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook  -i ./inventory.cfg ./prepare.yml
ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook  -i ./inventory.cfg /openshift-ansible/playbooks/prerequisites.yml
ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook  -i ./inventory.cfg /openshift-ansible/playbooks/deploy_cluster.yml
#ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook  -i ./inventory.cfg /openshift-ansible/playbooks/adhoc/uninstall.yml
