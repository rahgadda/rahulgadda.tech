#!/bin/bash

curl -s 'https://raw.githubusercontent.com/zerotier/ZeroTierOne/master/doc/contact%40zerotier.com.gpg' | gpg --import && \
if z=$(curl -s 'https://install.zerotier.com/' | gpg); then
    echo "$z" | sudo bash
fi

service zerotier-one restart
systemctl daemon-reload
systemctl status zerotier-one

zerotier-cli join <<id>>