#!/usr/bin/env bash
sudo yum update -y
sudo yum install -y https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
sudo yum install -y "@Development Tools" python2-pip openssl-devel python-devel gcc libffi-devel
sudo yum install -y pyOpenSSL python-cryptography python-lxml httpd-tools java-1.8.0-openjdk-headless
git clone -b release-3.11 https://github.com/openshift/openshift-ansible
sudo pip install --upgrade pip
pip install --upgrade setuptools
pip install -I ansible==2.6.5