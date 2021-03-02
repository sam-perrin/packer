#!/bin/bash  -eux
### Disable IPv6. ### 
echo '> Disabling IPv6'
echo "net.ipv6.conf.all.disable_ipv6 = 1" >> /etc/sysctl.conf