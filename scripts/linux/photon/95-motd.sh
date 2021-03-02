#!/bin/bash
### Set MOTD. ###
echo '> Setting MOTD ...'

OS=$(head -n 1 /etc/photon-release)
BUILD=$(tail -n 1 /etc/photon-release | awk -F"=" '{print (NF>1)? $NF : ""}')
RELEASE="$OS ($BUILD)"
DOCS="https://github.com/sam-perrin/packer"

# Create Issue
cat << ISSUE > /etc/issue
       _                   _      _   
      | |                 (_)    | |  
 __  _| |_ _ __ __ ___   ___ _ __| |_ 
 \ \/ / __| '__/ _` \ \ / / | '__| __|
  >  <| |_| | | (_| |\ V /| | |  | |_ 
 /_/\_\\__|_|  \__,_| \_/ |_|_|   \__|
                                                                   
        $RELEASE
        $DOCS
ISSUE

# MOTD symlinks
ln -sf /etc/issue /etc/issue.net