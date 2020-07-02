#!/bin/sh -ex
yum install -y vim wget curl rsync screen
yum -y groupinstall 'development tools'
#yum install -y --enablerepo epel open-vm-tools
yum install -y open-vm-tools cloud-init