#!/bin/bash

# -- Referenece Documents
# https://rancher.com/docs/k3s/latest/en/installation/install-options/server-config/
# https://rancher.com/docs/k3s/latest/en/advanced/
# https://www.upnxtblog.com/index.php/2020/07/10/how-to-setup-2-node-cluster-on-k3s/
# https://jonnylangefeld.com/blog/kubernetes-how-to-view-swagger-ui
#   kubectl proxy --port=8080  >>  http://localhost:8080/openapi/v3
#   curl localhost:8080/openapi/v2 > k8s-swagger.json
#   https://127.0.0.1:6443/openapi/v3
#   https://stackoverflow.com/questions/57449793/how-do-i-access-api-controller-config-in-lightweight-k3s
 
# -- List variables
echo "  -------------------------------------------"
echo "              SETUP ARGUMENTS"
echo "  -------------------------------------------"
echo "            Domain:   $DOMAIN_NAME"
echo "         Public IP:   $PUBLIC_IP"
echo "       Zerotier IP:   $MASTER_ZEROTIER_IP"
echo "  -------------------------------------------"

# -- Pre configurations
cat <<EOF |  tee /etc/yum.repos.d/kubernetes.repo
[kubernetes]
name=Kubernetes
baseurl=https://packages.cloud.google.com/yum/repos/kubernetes-el7-\$basearch
enabled=1
gpgcheck=1
repo_gpgcheck=1
gpgkey=https://packages.cloud.google.com/yum/doc/yum-key.gpg https://packages.cloud.google.com/yum/doc/rpm-package-key.gpg
exclude=kubelet kubeadm kubectl
EOF

setenforce 0
sed -i 's/^SELINUX=enforcing$/SELINUX=permissive/' /etc/selinux/config

yum install -y jq

# -- Install kubectl
yum install -y kubectl --disableexcludes=kubernetes

# -- Install K3S Server
curl -sfL https://get.k3s.io | sh -s - server \
    --docker \
    --node-name=$DOMAIN_NAME \
    --node-ip=$MASTER_ZEROTIER_IP \
    --node-external-ip=$PUBLIC_IP \
    --flannel-external-ip \
    --disable local-storage \
    --disable servicelb \
    --disable traefik
    # --flannel-backend none \
    # --disable "metrics-server"
    # --disable-network-policy \

# -- Configuring Kubconfig
rm -rf /root/.kube
rm -rf /home/opc/.kube
mkdir -p -m700 /root/.kube /home/opc/.kube
cp /etc/rancher/k3s/k3s.yaml /root/.kube/config
cp /etc/rancher/k3s/k3s.yaml /home/opc/.kube/config
chown $(id -u):$(id -g) /home/opc/.kube/config
chmod 600 /root/.kube/config
chmod 600 /home/opc/.kube/config

# -- Verify Installation
kubectl get nodes
kubectl get pod -A -o wide
kubectl get componentstatus

# -- Taint Master
# kubectl get nodes -o json | jq '.items[].spec.taints'
# kubectl taint nodes master.domainname.com node-role.kubernetes.io/control-plane:NoSchedule- 
# kubectl get nodes --show-labels

# -- Kompose
curl -L https://github.com/kubernetes/kompose/releases/download/v1.28.0/kompose-linux-arm64 -o kompose
chmod +x kompose
mv ./kompose /usr/bin/kompose

# -- List Token
cat /var/lib/rancher/k3s/server/node-token