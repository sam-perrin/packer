#!/bin/bash
# Prepares a Red Hat Enterprise Linux 8 Server guest operating system.

export BUILD_USERNAME
export RHSM_USERNAME
export RHSM_PASSWORD

#### Register Red Hat Subscription Manager to enable updates. ###
echo '> Registering Red Hat Subscription Manager to enable updates ...'
subscription-manager register --username $RHSM_USERNAME --password $RHSM_PASSWORD --auto-attach

#### Update the guest operating system. ###
echo '> Updating the guest operating system ...'
sudo yum update -y

### Install additional packages. ### 
echo '> Installing additional packages ...'
sudo yum install -y curl
sudo yum install -y wget
sudo yum install -y git
sudo yum install -y net-tools
sudo yum install -y unzip
sudo yum install -y ca-certificates
sudo yum install -y perl
sudo yum install -y cloud-init

### Clearing yum cache. ###
echo '> Clearing yum cache ...'
sudo yum clean all

# ### Copy the Certificate Authority certificates and add to the certificate authority trust. ###
# echo '> Copying the Certificate Authority certificates and adding to the certificate authority trust ...'
# sudo chown -R root:root /tmp/root-ca.crt
# sudo cat /tmp/root-ca.crt > /etc/pki/ca-trust/source/anchors/root-ca.crt
# sudo chmod 644 /etc/pki/ca-trust/source/anchors/root-ca.crt
# sudo update-ca-trust extract
# sudo rm -rf /tmp/root-ca.crt

# ### Copy the SSH key to authorized_keys and set permissions. ###
# echo '> Copying the SSH key to Authorized Keys and setting permissions ...'
# sudo mkdir -p /home/$BUILD_USERNAME/.ssh
# sudo chmod 700 /home/$BUILD_USERNAME/.ssh
# sudo cat /tmp/id_ecdsa.pub > /home/$BUILD_USERNAME/.ssh/authorized_keys
# sudo chmod 644 /home/$BUILD_USERNAME/.ssh/authorized_keys
# sudo chown -R $BUILD_USERNAME /home/rainpole/.ssh
# sudo rm -rf /tmp/id_ecdsa.pub

### Configure SSH for Public Key Authentication. ###
echo '> Configuring SSH for Public Key Authentication ...'
sudo sed -i '/^PermitRootLogin/s/yes/no/' /etc/ssh/sshd_config
sudo sed -i "s/.*PubkeyAuthentication.*/PubkeyAuthentication yes/g" /etc/ssh/sshd_config
sudo sed -i '/^PasswordAuthentication/s/no/yes/' /etc/ssh/sshd_config

### Restart the SSH daemon. ###
echo '> Restarting the SSH daemon. ...'
sudo systemctl restart sshd

### Disable SELinux. ### 
echo '> Disabling SELinux ...'
sudo sed -i 's/^SELINUX=enforcing/SELINUX=disabled/g' /etc/selinux/config

### Disable and clean tmp. ### 
echo '> Disabling and clean tmp ...'
SOURCE_TEXT="v /tmp 1777 root root 10d"
DEST_TEXT="#v /tmp 1777 root root 10d"
sudo sed -i "s@${SOURCE_TEXT}@${DEST_TEXT}@g" /usr/lib/tmpfiles.d/tmp.conf
sudo sed -i "s/\(^.*10d.*$\)/#\1/" /usr/lib/tmpfiles.d/tmp.conf

### Add After=dbus.service to VMware Tools daemon. ### 
echo '> Adding After=dbus.service to VMware Tools daemon ...'
sudo sed -i '/^After=vgauthd.service/a\After=dbus.service' /usr/lib/systemd/system/vmtoolsd.service

### Disable VMware Customisation ### 
echo '> Disabling VMware Customisation...'
sudo sed -i '/^disable_vmware_customization:/s/false/true/' /etc/cloud/cloud.cfg
sudo tee -a /etc/cloud/cloud.cfg > /dev/null <<EOT
network: { config: “disabled” }
EOT
# sudo yum install https://github.com/vmware/cloud-init-vmware-guestinfo/releases/download/v1.1.0/cloud-init-vmware-guestinfo-1.1.0-1.el7.noarch.rpm
# sudo vmware-toolbox-cmd config set deployPkg enable-custom-scripts true

### Clean Cloud-Init. ### 
echo '> Cleaning Cloud-Init...'
sudo cloud-init clean

### Create a cleanup script. ###
echo '> Creating cleanup script ...'
sudo cat <<EOF > /tmp/clean.sh
#!/bin/bash

# Cleans all audit logs.
echo '> Cleaning all audit logs ...'
if [ -f /var/log/audit/audit.log ]; then
cat /dev/null > /var/log/audit/audit.log
fi
if [ -f /var/log/wtmp ]; then
cat /dev/null > /var/log/wtmp
fi
if [ -f /var/log/lastlog ]; then
cat /dev/null > /var/log/lastlog
fi

# Cleans persistent udev rules.
echo '> Cleaning persistent udev rules ...'
if [ -f /etc/udev/rules.d/70-persistent-net.rules ]; then
rm /etc/udev/rules.d/70-persistent-net.rules
fi

# Cleans /tmp directories.
echo '> Cleaning /tmp directories ...'
rm -rf /tmp/*
rm -rf /var/tmp/*
rm -rf /var/log/rhsm/*
rm -rf /var/cache/yum/*

# Cleans SSH keys.
echo '> Cleaning SSH keys ...'
#rm -f /etc/ssh/ssh_host_*

# Sets hostname to localhost.
echo '> Setting hostname to localhost ...'
cat /dev/null > /etc/hostname
hostnamectl set-hostname localhost

# Cleans yum.
echo '> Cleaning yum ...'
yum clean all

# Cleans the machine-id.
echo '> Cleaning the machine-id ...'
truncate -s 0 /etc/machine-id
rm /var/lib/dbus/machine-id
ln -s /etc/machine-id /var/lib/dbus/machine-id

# Cleans shell history.
echo '> Cleaning shell history ...'
unset HISTFILE
history -cw
echo > ~/.bash_history
rm -fr /root/.bash_history

# Run a sync for giggles. And then again.
sync && sync

EOF

### Change script permissions for execution. ### 
echo '> Changeing script permissions for execution ...'
sudo chmod +x /tmp/clean.sh

### Executes the cleauup script. ### 
echo '> Executing the cleanup script ...'
sudo /tmp/clean.sh

#### Unegister from Red Hat Subscription Manager. ###
echo '> Unegistering from Red Hat Subscription Manager ...'
subscription-manager unsubscribe --all
subscription-manager unregister
subscription-manager clean

### All done. ### 
echo '> Done.'  


