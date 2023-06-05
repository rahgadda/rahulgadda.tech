#!/bin/bash

AGENT3_PUBLIC_IP=$(curl -s ifconfig.me)
AGENT3_PRIVATE_IP=$(hostname -I | cut -f 1 -d " ")
AGENT3_DOMAIN_NAME="agent3.domainname.com"
AGENT3_ZEROTIER_IP=$(echo $(hostname -I) | cut -d " " -f 3)

MATCHES_IN_HOSTS="$(grep -n $AGENT3_PUBLIC_IP /etc/hosts)"
hostnamectl set-hostname $AGENT3_DOMAIN_NAME

# Master
MASTER_DOMAIN_NAME="master.domainname.com"
MASTER_PUBLIC_IP=$(dig +short master.domainname.com)
MASTER_ZEROTIER_IP="192.168.1.24"

# Agent 1
# AGENT1_DOMAIN_NAME="agent1.domainname.com"
# AGENT1_PUBLIC_IP=$(dig +short agent1.domainname.com)
# AGENT1_ZEROTIER_IP="192.168.1.1"

# Agent 2
AGENT2_DOMAIN_NAME="agent2.domainname.com"
AGENT2_PUBLIC_IP=$(dig +short agent2.domainname.com)
AGENT2_ZEROTIER_IP="192.168.1.2"

# Agent 4
AGENT4_DOMAIN_NAME="agent4.domainname.com"
AGENT4_PUBLIC_IP=$(dig +short agent4.domainname.com)
AGENT4_ZEROTIER_IP="192.168.1.4"

# Agent 5
AGENT5_DOMAIN_NAME="agent5.domainname.com"
AGENT5_PUBLIC_IP=$(dig +short agent5.domainname.com)
AGENT5_ZEROTIER_IP="192.168.1.5"

if [ ! -z "$MATCHES_IN_HOSTS" ] 
then
    echo "Host Details Already Exisits"
else 
    echo "Registering Host Details";
    echo "===================================";
    cat /dev/null > /etc/hosts;
    echo "127.0.0.1   localhost localhost.localdomain localhost4 localhost4.localdomain4" >> /etc/hosts;
    echo "::1         localhost localhost.localdomain localhost6 localhost6.localdomain6" >> /etc/hosts;
    echo "$MASTER_ZEROTIER_IP $MASTER_PUBLIC_IP $MASTER_DOMAIN_NAME" >> /etc/hosts;
    # echo "$AGENT1_ZEROTIER_IP $AGENT1_PUBLIC_IP $AGENT1_DOMAIN_NAME" >> /etc/hosts;
    echo "$AGENT2_ZEROTIER_IP $AGENT2_PUBLIC_IP $AGENT2_DOMAIN_NAME" >> /etc/hosts;
    echo "$AGENT3_ZEROTIER_IP $AGENT3_PUBLIC_IP $AGENT3_DOMAIN_NAME" >> /etc/hosts;
    echo "$AGENT4_ZEROTIER_IP $AGENT4_PUBLIC_IP $AGENT4_DOMAIN_NAME" >> /etc/hosts;
    echo "$AGENT5_ZEROTIER_IP $AGENT5_PUBLIC_IP $AGENT5_DOMAIN_NAME" >> /etc/hosts;
    echo "========Updated Details============";
    cat /etc/hosts
    echo "===================================";
fi