#!/bin/bash

echo "[+] Copying audit policy to /etc/kubernetes/"
sudo cp audit-policy.yaml /etc/kubernetes/

echo "[+] Ensuring log directory exists"
sudo mkdir -p /var/log/kubernetes/

echo "[+] Patching API server static pod manifest"
sudo sed -i '/--secure-port=6443/a \    - --audit-policy-file=/etc/kubernetes/audit-policy.yaml\n    - --audit-log-path=/var/log/kubernetes/audit.log' /etc/kubernetes/manifests/kube-apiserver.yaml

echo "[+] kube-apiserver will restart automatically"
