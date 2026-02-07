#!/bin/bash
echo "[+] Checking if RuntimeClass is set..."
kubectl get pod sandboxed -o jsonpath='{.spec.runtimeClassName}'; echo
