#!/bin/bash
### Configure SSH for Public Key Authentication. ###
echo '> Configuring SSH for Public Key Authentication ...'

# Disable root login via SSH
#sudo sed -i '/^PermitRootLogin/s/yes/no/' /etc/ssh/sshd_config
# Removed 7th July 2022, contradicts what cloud-init script does by enabling root login

# Enable public key authentication
sudo sed -i "s/.*PubkeyAuthentication.*/PubkeyAuthentication yes/g" /etc/ssh/sshd_config

# Enable password authentication
sudo sed -i '/^PasswordAuthentication/s/no/yes/' /etc/ssh/sshd_config

### Restart the SSH daemon. ###
echo '> Restarting the SSH daemon. ...'
sudo systemctl restart sshd