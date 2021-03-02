#!/bin/bash
### Set MOTD. ###
echo '> Setting MOTD ...'

RELEASE=$(lsb_release -d)
DOCS="https://github.com/sam-perrin/packer"

# Create Issue
cat << ISSUE > /etc/issue
xtravirt.com
                                                                   
        $RELEASE
        $DOCS
ISSUE

# MOTD symlinks
ln -sf /etc/issue /etc/issue.net