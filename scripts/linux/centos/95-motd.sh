#!/bin/bash
### Set MOTD. ###
echo '> Setting MOTD ...'

RELEASE=$(cat /etc/centos-release)
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