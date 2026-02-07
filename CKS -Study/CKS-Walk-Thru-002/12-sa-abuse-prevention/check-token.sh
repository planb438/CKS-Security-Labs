#!/bin/bash
echo "[+] Checking for mounted service account token"
kubectl exec -n sa-test exploitable -- ls /var/run/secrets/kubernetes.io/serviceaccount/
