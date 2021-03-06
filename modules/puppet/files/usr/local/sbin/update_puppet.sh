#!/bin/bash

#Sanity checks
if [[ $EUID -ne 0 ]]; then
    echo "This script must be run as root" 1>&2
    exit 1
fi

#Abort if no git/puppet
command -v git >/dev/null 2>&1 || { echo "I require git but it's not installed. Please install git-core if on debian/ubuntu" >&2; exit 1; }
command -v puppet >/dev/null 2>&1 || { echo "I require puppet but it's not installed. Please install puppet if on debian/ubuntu" >&2; exit 1; }

#If the puppet dir does not exist, clone it
#if [ ! -d "/etc/puppet" ]; then
#    cd /etc
#    git clone https://github.com/jippen/personal-puppet.git /etc/puppet
#fi

cd /etc/puppet

#Nuke local changes
#git stash -q

#Update repo
git pull -q
git submodule init -q
git submodule update -q

#Apply changes
/usr/bin/puppet apply $@ /etc/puppet/manifests/site.pp
