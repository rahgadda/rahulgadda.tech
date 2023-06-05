#!/bin/bash

# -- Reference
# https://blog.differentpla.net/blog/2021/12/21/installing-longhorn/

# -- Installation
yum install iscsi-initiator-utils -y
helm repo add longhorn https://charts.longhorn.io
helm repo update
helm repo list
helm install longhorn longhorn/longhorn --namespace longhorn --create-namespace

# -- Create Ingress
kubectl apply -f /home/opc/setup/11-longhorn/longhorn-ingress.yaml

# -- Verification
kubectl get all -n longhorn
kubectl get storageclass
kubectl get service longhorn-frontend --namespace longhorn
# kubectl get CSIDriver -A
# kubectl describe CSIDriver driver.longhorn.io
kubectl get CSINode  -A
kubectl get volumes -A

# -- Dependency Sequence
# longhorn-conversion-webhook-5c75577484-snm7d
# longhorn-admission-webhook-65669f9957-wzfkj
# longhorn-manager-6lrt9
# longhorn-driver-deployer-9d85f7675-xkz7j
# longhorn-ui-5d8569577-w7lsr

# -- Update Setting
# Replica Node Level Soft Anti-Affinity = True
# Default Replica Count = 1
# Concurrent Volume Backup Restore Per Node Limit = 0
# Allow Volume Creation With Degraded Availability = true
