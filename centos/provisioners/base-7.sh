#!/bin/sh -ex
sed -i "s/^.*requiretty/#Defaults requiretty/" /etc/sudoers
#yum -y install ${SUDO:-sudo-1.8.6p7-16.el7}
yum install -y ${EPEL_RELEASE:-epel-release}

#sudo yum check-update
sudo yum update -y
