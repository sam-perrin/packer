DEPLOY_HOSTNAME=$(hostname)
DEPLOY_IP=$(ip addr show label ens\* | grep -oP '(?<=inet\s)\d+(\.\d+){3}')

echo $DEPLOY_HOSTNAME >> /home/${DEPLOY_USERNAME:-deploy}/serverinfo-$(hostname).txt
echo $DEPLOY_IP >> /home/${DEPLOY_USERNAME:-deploy}/serverinfo-$(hostname).txt