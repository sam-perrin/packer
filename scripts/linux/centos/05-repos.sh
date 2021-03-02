#!/bin/bash
#### Add additional repos. ###
echo '> Adding additional repos ...'

# Add SaltStack repo
sudo yum install https://repo.saltstack.com/py3/redhat/salt-py3-repo-latest.el8.noarch.rpm -y

# Add HashiCorp repo
sudo yum install -y yum-utils
sudo yum-config-manager --add-repo https://rpm.releases.hashicorp.com/RHEL/hashicorp.repo

# Add epel-release
sudo yum install -y epel-release