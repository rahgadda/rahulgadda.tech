#!/bin/bash

# -- Installation
helm repo add weaviate https://weaviate.github.io/weaviate-helm
helm install weaviate weaviate/weaviate --namespace weaviate --create-namespace

# -- Update SVC to ClusterIP
kubectl edit svc weaviate -n weaviate

# -- Ingress
kubectl apply -f /home/opc/setup/12-weaviate/weaviate-ingress.yaml

# -- Update Retention Policy of PV
kubectl get pv --no-headers -o custom-columns=:metadata.name | xargs -I {} kubectl patch pv {} -p '{"spec":{"persistentVolumeReclaimPolicy":"Retain"}}'
