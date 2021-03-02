#!/bin/bash  -eux
### Install additional packages. ### 
echo '> Installing additional packages ...'
sudo tdnf install -y curl
sudo tdnf install -y wget
sudo tdnf install -y git
sudo tdnf install -y net-tools
sudo tdnf install -y unzip
sudo tdnf install -y ca-certificates
sudo tdnf install -y openssl-c_rehash