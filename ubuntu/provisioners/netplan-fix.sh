mv /etc/netplan/01-netcfg.yaml /etc/netplan/01-netcfg.yaml.old

echo "Create netplan config for eth0"
cat <<EOF >> /etc/netplan/01-netcfg.yaml
network:
  version: 2
  renderer: networkd
  ethernets:
    ens192:
      dhcp4: yes
      dhcp-identifier: mac
EOF