#!/bin/bash
echo "[+] Grepping for secret access in audit log..."
sudo grep 'demo-secret' /var/log/kubernetes/audit.log | jq .
