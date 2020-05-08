DEPLOY_HOSTNAME=$(hostname)
echo $DEPLOY_HOSTNAME >> serverinfo-$(hostname).txt

DEPLOY_IP=$(ip addr show label ens\* | grep -oP '(?<=inet\s)\d+(\.\d+){3}')
echo $DEPLOY_IP >> serverinfo-$(hostname).txt