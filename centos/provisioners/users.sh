useradd deploy
echo "deploy" | passwd deploy --stdin
usermod -a -G wheel deploy
yum install -y sudo
echo "deploy        ALL=(ALL)       NOPASSWD: ALL" >> /etc/sudoers.d/deploy
sed -i "s/^.*requiretty/#Defaults requiretty/" /etc/sudoers