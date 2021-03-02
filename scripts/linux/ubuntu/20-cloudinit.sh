#!/bin/bash
### Install cloud-init. ###
echo '> Installing cloud-init ...'
sudo apt-get install -y perl
sudo apt-get install -y cloud-init

### Add After=dbus.service to open-vm-tools. ### 
echo '> Adding After=dbus.service to open-vm-tools ...'
sudo sed -i '/^After=vgauthd.service/a\After=dbus.service' /lib/systemd/system/open-vm-tools.service

### Disable VMware Customisation ### 
echo '> Disabling VMware Customisation...'
sudo sed -i '/^disable_vmware_customization:/s/false/true/' /etc/cloud/cloud.cfg
sudo tee -a /etc/cloud/cloud.cfg > /dev/null <<EOT
network: { config: “disabled” }
EOT

### Clean Cloud-Init. ### 
echo '> Cleaning Cloud-Init...'
sudo cloud-init clean