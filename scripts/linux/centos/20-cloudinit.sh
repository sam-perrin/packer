#!/bin/bash
### Install cloud-init. ###
echo '> Installing cloud-init ...'
sudo yum install -y perl
sudo yum install -y cloud-init

# Disable cloud-init on boot
sudo touch /etc/cloud/cloud-init.disabled

# Enable SSH password auth and root login
sudo sed -i 's/^ssh_pwauth:   0/ssh_pwauth:   1/g' /etc/cloud/cloud.cfg
sudo sed -i 's/^disable_root: 1/disable_root: 0/g' /etc/cloud/cloud.cfg

# Remove user section
sudo sed -i -e '/users:/,+1d' /etc/cloud/cloud.cfg

echo '> Disabling VMware Customisation...'
# Disable VMware customization to facilitate static IP address assignment
sudo sed -i "s/^disable_vmware_customization: false/disable_vmware_customization: true/g" /etc/cloud/cloud.cfg
# Disable network configuration if VMware customization is true
sudo sed -i "/disable_vmware_customization: true/a\network:" /etc/cloud/cloud.cfg
sudo sed -i '/^network:/a\  config: disabled' /etc/cloud/cloud.cfg

# Disable EC2 callback and restrict datasource list
sudo sed -i '1 i\disable_ec2_metadata: True' /etc/cloud/cloud.cfg
# Set the datasource as OVF only 
sudo sed -i '1 i\datasource_list: ["OVF", "None"]' /etc/cloud/cloud.cfg
#sed -i '/^disable_vmware_customization: true/a\datasource_list: [OVF]' /etc/cloud/cloud.cfg

# Disable /tmp folder clearing (using @ as separator)
SOURCE_TEXT="v /tmp 1777 root root 10d"
DEST_TEXT="#v /tmp 1777 root root 10d"
sudo sed -i "s@${SOURCE_TEXT}@${DEST_TEXT}@g" /usr/lib/tmpfiles.d/tmp.conf
sudo sed -i "s/\(^.*10d.*$\)/#\1/" /usr/lib/tmpfiles.d/tmp.conf
sudo sed -i "s@^[a-z] /tmp @# &@" /usr/lib/tmpfiles.d/tmp.conf

### Add After=dbus.service to VMware Tools daemon. ### 
echo '> Adding After=dbus.service to VMware Tools daemon ...'
sudo sed -i '/^After=vgauthd.service/a\After=dbus.service' /usr/lib/systemd/system/vmtoolsd.service

# Create runonce.sh script
cat << RUNONCE > /etc/cloud/runonce.sh
#!/bin/bash
# Enable cloud-init
sudo rm -f /etc/cloud/cloud-init.disabled
# Execute cloud-init
sudo cloud-init init
sleep 20
sudo cloud-init modules --mode config
sleep 20
sudo cloud-init modules --mode final
# Mark cloud-init as complete
sudo touch /etc/cloud/cloud-init.disabled
sudo touch /tmp/cloud-init.complete
sudo crontab -r
sudo eject --cdrom
# Restart sshd
sudo systemctl restart sshd
RUNONCE

# Set execute permissions on runonce.sh
chmod +rx /etc/cloud/runonce.sh

# Schedule runonce.sh in crontab
sudo echo "$(echo '@reboot ( sleep 30 ; sh /etc/cloud/runonce.sh )' ; crontab -l)" | crontab -