#rm -rf /tmp/* /root/*

echo "==> Force logs to rotate"
/usr/sbin/logrotate -f /etc/logrotate.conf
/bin/rm -f /var/log/*-???????? /var/log/*.gz

echo "==> Clear wtmp"
/bin/cat /dev/null > /var/log/wtmp

echo "==> Cleaning up udev rules"
/bin/rm -f /etc/udev/rules.d/70*

echo "==> Remove the traces of the template MAC address and UUIDs"

sed -i'' -e '/UUID=/d' /etc/sysconfig/network-scripts/ifcfg-eth0
sed -i'' -e '/HWADDR=/d' /etc/sysconfig/network-scripts/ifcfg-eth0
sed -i'' -e '/DHCP_HOSTNAME=/d' /etc/sysconfig/network-scripts/ifcfg-eth0
sed -i'' -e 's/NM_CONTROLLED=.*/NM_CONTROLLED="no"/' /etc/sysconfig/network-scripts/ifcfg-eth0

echo "==> Cleaning up tmp"
/bin/rm -rf /tmp/*
/bin/rm -rf /var/tmp/*

echo "==> Remove the SSH host keys"
/bin/rm -f /etc/ssh/*key*

echo "==> Remove the root user’s shell history"
/bin/rm -f ~root/.bash_history
unset HISTFILE