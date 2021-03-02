#!/bin/bash  -eux
### Install cloud-init packages. ### 
echo '> Installing cloud-init packages ...'
sudo tdnf install -y perl
sudo tdnf install -y cloud-init

### Add After=dbus.service to VMware Tools daemon. ### 
echo '> Adding After=dbus.service to VMware Tools daemon ...'
sudo sed -i '/^After=vgauthd.service/a\After=dbus.service' /usr/lib/systemd/system/vmtoolsd.service

### Disable VMware Customisation ### 
echo '> Disabling VMware Customisation...'
sudo sed -i '/^disable_vmware_customization:/s/false/true/' /etc/cloud/cloud.cfg
sudo tee -a /etc/cloud/cloud.cfg > /dev/null <<EOT
network: { config: “disabled” }
EOT

### Clean Cloud-Init. ### 
echo '> Cleaning Cloud-Init...'
sudo cloud-init clean