#!/bin/bash
echo "[+] Falco alerts in last 30s (if any):"
kubectl logs -n falco -l app.kubernetes.io/name=falco --since=30s # --tail=100
