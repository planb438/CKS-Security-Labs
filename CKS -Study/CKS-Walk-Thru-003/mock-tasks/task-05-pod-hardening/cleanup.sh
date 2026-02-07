#!/bin/bash
echo "[+] Cleaning up..."
# Delete the secure pod
kubectl delete pod secure-pod --ignore-not-found
