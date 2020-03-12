mkdir -pm 700 /home/${DEPLOY_USERNAME:=deploy}/.ssh
curl -kL 'https://raw.github.com/mitchellh/vagrant/master/keys/vagrant.pub' >> /home/$DEPLOY_USERNAME/.ssh/authorized_keys
chmod 0600 /home/$DEPLOY_USERNAME/.ssh/authorized_keys
chown -R $DEPLOY_USERNAME:$DEPLOY_USERNAME /home/$DEPLOY_USERNAME/.ssh
if grep "^UseDNS yes" /etc/ssh/sshd_config; then
  sed "s/^UseDNS yes/UseDNS no/" /etc/ssh/sshd_config > /tmp/sshd_config
  mv /tmp/sshd_config /etc/ssh/sshd_config
else
  echo "UseDNS no" >> /etc/ssh/sshd_config
fi
echo "deploy ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers.d/$DEPLOY_USERNAME
chmod 0440 /etc/sudoers.d/$DEPLOY_USERNAME
