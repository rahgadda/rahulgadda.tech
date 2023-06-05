#!/bin/bash

# -- List variables
echo ""
echo "           Registering Host Details";
echo "  ============================================";
echo "    PUBLIC_IP:           $AGENT5_PUBLIC_IP"
echo "    DOMAIN_NAME:         $AGENT5_DOMAIN_NAME"
echo "    AGENT5_ZEROTIER_IP:  $AGENT5_ZEROTIER_IP"
echo "    MSTER_PUBLIC_IP:     $MASTER_PUBLIC_IP"
echo "    MASTER_DOMAIN_NAME:  $MASTER_DOMAIN_NAME"
echo "  ============================================";
echo ""

# https://stackoverflow.com/questions/51878195/kubernetes-cross-namespace-ingress-network/51899301#51899301
# -- Install Agent
curl -sfL https://get.k3s.io | K3S_URL=https://$MASTER_PUBLIC_IP:6443 \
INSTALL_K3S_EXEC="agent --node-ip=$AGENT5_ZEROTIER_IP --node-external-ip=$AGENT5_PUBLIC_IP --docker" \
K3S_TOKEN=K1036950fd57b17e3368e3b12ea5cac100efe19dab6e62ca358f6e921b5d185e24b::server:31a1a6f9a5d775dade2dfc9b2c6b68c6 sh -