#!/bin/bash

# -- Unistall
kubectl delete -f /home/opc/setup/12-weaviate/weaviate-ingress.yaml
helm uninstall weaviate -n weaviate
kubectl get all -n weaviate