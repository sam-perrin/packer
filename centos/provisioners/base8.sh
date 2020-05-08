#!/bin/sh -ex
sed -i "s/^.*requiretty/#Defaults requiretty/" /etc/sudoers
#yum -y install ${SUDO:-sudo-1.8.6p7-16.el7}
dnf install -y ${EPEL_RELEASE:-epel-release}
sudo hostnamectl set-hostname ${NEW_HOSTNAME}