#!/bin/bash
#### Update the guest operating system. ###
echo '> Updating the guest operating system ...'
sudo yum update -y

# Reinstall CA certificates
sudo yum reinstall -y ca-certificates