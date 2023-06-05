#!/bin/bash

kubectl -n kube-system delete deployments --all
kubectl delete daemonsets -n kube-system --all
kubectl -n kube-system delete services --all
kubectl -n kube-system delete pods --all

/usr/local/bin/k3s-uninstall.sh

systemctl restart kubelet
yum remove -y kubelet kubeadm
systemctl stop kubelet
systemctl disable kubelet
systemctl daemon-reload
systemctl status kubelet

iptables -F && iptables -t nat -F && iptables -t mangle -F && iptables -X
iptables -L -n

rm -rf /etc/kubernetes
rm -rf /etc/cni/net.d
rm -rf /var/lib/kubelet
rm -rf /var/lib/etcd
rm -rf /root/.kube
rm -rf /home/opc/.kube

ip link delete cni0
ip link delete flannel.1
ip link