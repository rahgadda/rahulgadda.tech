#!/bin/bash

# -- Reference
# https://devopscube.com/configure-ingress-tls-kubernetes/

# -- Install CRD
kubectl create ns cert-manager
kubectl label namespace cert-manager certmanager.k8s.io/disable-validation=true
kubectl apply -f https://github.com/jetstack/cert-manager/releases/latest/download/cert-manager.yaml

# -- Install Certificate Manager Kubernetes Plugin
curl -L -o kubectl-cert-manager.tar.gz  https://github.com/jetstack/cert-manager/releases/latest/download/kubectl-cert_manager-linux-arm64.tar.gz
tar xzf kubectl-cert-manager.tar.gz
mv kubectl-cert_manager /usr/bin

rm -rf kubectl-cert-manager.tar.gz

# -- ClusterIssuer
kubectl apply -f /home/opc/setup/09-certificate/cluster-issuer.yaml
kubectl apply -f /home/opc/setup/09-certificate/certificate.yaml

# -- Verification
kubectl cert-manager help
kubectl cert-manager check api

kubectl get CustomResourceDefinition -A
kubectl get pods -n cert-manager
kubectl describe ClusterIssuer clusterissuer -n cert-manager

kubectl get ClusterIssuer
kubectl get Certificates -A
kubectl get CertificateRequests -A
kubectl get Orders -A
kubectl get Challenges -A
kubectl get events -A