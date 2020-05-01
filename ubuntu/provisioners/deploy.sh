if grep "^UseDNS yes" /etc/ssh/sshd_config; then
  sed "s/^UseDNS yes/UseDNS no/" /etc/ssh/sshd_config > /tmp/sshd_config
  mv /tmp/sshd_config /etc/ssh/sshd_config
else
  echo "UseDNS no" >> /etc/ssh/sshd_config
fi
echo "deploy ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers.d/${DEPLOY_USERNAME:=deploy}
chmod 0440 /etc/sudoers.d/$DEPLOY_USERNAME