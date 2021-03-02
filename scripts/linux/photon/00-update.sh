#!/bin/bash  -eux
#### Update the guest operating system. ###
echo '> Updating the guest operating system ...'
sudo sed -i 's/dl.bintray.com\/vmware/packages.vmware.com\/photon\/$releasever/g' /etc/yum.repos.d/*.repo
sudo tdnf -y update photon-repos
sudo tdnf clean all
sudo tdnf makecache
sudo tdnf update -y