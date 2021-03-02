#!/bin/bash
### Set MOTD. ###
echo '> Setting MOTD ...'

RELEASE=$(cat /etc/centos-release)
DOCS="https://github.com/sam-perrin/packer"

# Create Issue
cat << ISSUE > /etc/issue
xtravirt.com
                                                                   
        $RELEASE
        $DOCS
ISSUE

# MOTD symlinks
ln -sf /etc/issue /etc/issue.net