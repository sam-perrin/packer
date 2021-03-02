#!/bin/bash
### Set MOTD. ###
echo '> Setting MOTD ...'

OS=$(head -n 1 /etc/photon-release)
BUILD=$(tail -n 1 /etc/photon-release | awk -F"=" '{print (NF>1)? $NF : ""}')
RELEASE="$OS ($BUILD)"
DOCS="https://github.com/sam-perrin/packer"

# Create Issue
cat << ISSUE > /etc/issue
xtravirt.com
                                                                   
        $RELEASE
        $DOCS
ISSUE

# MOTD symlinks
ln -sf /etc/issue /etc/issue.net