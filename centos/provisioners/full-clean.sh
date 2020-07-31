#!/bin/bash -eux

CLEANUP_PAUSE=${CLEANUP_PAUSE:-0}
echo "==> Pausing for ${CLEANUP_PAUSE} seconds..."
sleep ${CLEANUP_PAUSE}

echo "==> Force logs to rotate"
/usr/sbin/logrotate -f /etc/logrotate.conf
/bin/rm -f /var/log/*-???????? /var/log/*.gz

echo "==> Clear wtmp"
/bin/cat /dev/null > /var/log/wtmp

echo "==> Cleaning up udev rules"
/bin/rm -f /etc/udev/rules.d/70*

# echo "==> Remove the traces of the template MAC address and UUIDs"

# sed -i'' -e '/UUID=/d' /etc/sysconfig/network-scripts/ifcfg-ens33
# sed -i'' -e '/HWADDR=/d' /etc/sysconfig/network-scripts/ifcfg-ens33
# sed -i'' -e '/DHCP_HOSTNAME=/d' /etc/sysconfig/network-scripts/ifcfg-ens33
# sed -i'' -e 's/NM_CONTROLLED=.*/NM_CONTROLLED="no"/' /etc/sysconfig/network-scripts/ifcfg-ens33

echo "==> Cleaning up tmp"
/bin/rm -rf /tmp/*
/bin/rm -rf /var/tmp/*

#echo "==> Remove the SSH host keys"
#/bin/rm -f /etc/ssh/*key*

echo "==> Remove the root user’s shell history"
/bin/rm -f ~root/.bash_history
unset HISTFILE

# echo "==> Zero out the free space to save space in the final image"
# # Zero out the rest of the free space using dd, then delete the written file.
# dd if=/dev/zero of=/EMPTY bs=1M
# rm -f /EMPTY

# # Add `sync` so Packer doesn't quit too early, before the large file is deleted.
# sync