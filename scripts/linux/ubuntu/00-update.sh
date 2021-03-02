#!/bin/bash
#### Update the guest operating system. ###
echo '> Updating the guest operating system ...'
sudo apt-get update
sudo apt-get -y upgrade
