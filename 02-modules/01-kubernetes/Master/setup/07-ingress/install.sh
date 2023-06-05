#!/bin/bash

# -- Reference
# https://faun.pub/free-ha-multi-architecture-kubernetes-cluster-from-oracle-c66b8ce7cc37

# -- Pre Installation
kubectl create clusterrolebinding permissive-binding \
  --clusterrole=cluster-admin \
  --user=admin \
  --user=kubelet \
  --group=system:serviceaccounts

# -- Add Helm Repository
helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
helm repo update
helm repo list

# -- Generat Nginx Configuration
# helm show values ingress-nginx/ingress-nginx > ngingress-metal-custom.yaml
# mv ngingress-metal-custom.yaml /home/opc/setup/ingress/ingress-nginx-controller.yml
# chmod 777 /home/opc/setup/ingress/ingress-nginx-controller.yml

# -- Update below values
# hostNetwork: true ## change to false
# #...
# hostPort:
#   enabled: false ## change to true
#
# #...
# kind: Deployment ## change to DaemonSet
#
# #...
# externalIPs: [] ## change to below
# externalIPS:
#   - arm.public.ip1/32 ## replace with your instance's IP
#   - arm.public.ip2/32 ## replace with your instance's IP
#
# #...
# loadBalancerSourceRanges: [] ## change to below
# loadBalancerSourceRanges:
#   - arm.public.ip1/32 ## replace with your instance's IP
#   - arm.public.ip2/32 ## replace with your instance's IP

#  -- Use Helm to deploy an NGINX ingress controller
# helm install ingress-nginx ingress-nginx/ingress-nginx --create-namespace --namespace  ingress --values /root/ngingress-metal-custom.yaml
helm install ingress-nginx ingress-nginx/ingress-nginx --create-namespace --namespace  ingress --values ngingress-metal-custom_no_port_update.yaml

# -- Get service details
kubectl get svc -n ingress
kubectl get svc ingress-nginx-controller -n ingress
# kubectl edit svc ingress-nginx-controller -n ingress
kubectl get validatingwebhookconfigurations
# kubectl edit validatingwebhookconfigurations ingress-nginx-admission

# -- Verification
helm list -n ingress
kubectl get svc ingress-nginx-controller -n ingress
kubectl describe svc ingress-nginx-controller -n ingress

# -- Update Port
# helm uninstall ingress-nginx -n ingress
# helm install ingress-nginx ingress-nginx/ingress-nginx --create-namespace --namespace  ingress --values ngingress-metal-custom_port_updated.yaml
# curl --insecure https://10.0.0.150:10250/containerLogs/ingress/ingress-nginx-controller-rsxw6/controller
# curl --insecure https://152.70.75.79:10250/containerLogs/ingress/ingress-nginx-controller-rsxw6/controller
# kubectl logs -n cilium -l k8s-app=cilium-agent
# kubectl get cm cilium-config -n cilium -o yaml

# cat <<EOF | kubectl apply -f -
# apiVersion: v1
# kind: ConfigMap
# metadata:
#   name: cilium-config
#   namespace: cilium
# data:
#   config.yaml: |
#     nodeIPAutoDetectionMethod: "interface=public"
# EOF
