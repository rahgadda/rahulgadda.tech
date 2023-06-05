#!/bin/bash

# -- Unistall
kubectl delete -f /root/setup/longhorn/longhorn-ingress.yaml
helm uninstall longhorn -n longhorn --no-hooks
kubectl get all -n longhorn