#!/bin/bash
kubectl apply -f 00-namespace.yaml
kubectl apply -f test-secret.yaml
kubectl get secret demo-secret -n audit-task -o yaml > /dev/null
