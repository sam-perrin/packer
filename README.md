# Packer Builders

## Install Packer 

[https://www.packer.io/docs/install/](https://www.packer.io/docs/install/)

## Running Builds

These builds are made to work with VMware Workstation.
TODO: vCenter builders ` https://www.packer.io/docs/builders/vmware/vsphere-iso/ `


Change in to the relevant directory and issue `packer build`
```
cd d:\packer\centos\centos-7\
packer build centos-7.json 
```
```
cd d:\packer\ubuntu\ubuntu-18.04
packer build ubuntu-18.04.json
```

## Build Details

CentOS 7 & 8
- Username: `root`
- Password: `deploy`

Ubuntu
- Username: `deploy`
- Password: `deploy`

## General Info

CentOS builds utilise kickstart file found in \centos\http\ks.cfg
Ubuntu builds utilise seed file found in \ubuntu\http\ubuntu-server.seed

CentOS 7 - tested build 24/05/2020
CentOS 8 - tested build 24/05/2020
Ubuntu 18.04 - not tested recently
Ubuntu 18.04 - tested build 24/05/2020