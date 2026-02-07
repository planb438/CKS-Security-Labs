#!/bin/bash
kubectl create -f test-secret.yaml
kubectl get secret test-audit -o yaml > /dev/null
