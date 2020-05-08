#!/bin/sh -ex
dnf install -y vim wget curl rsync screen
dnf -y groupinstall 'development tools'
dnf install -y ansible
ansible --version