#!/bin/bash
echo "[+] Cleaning up..."
kubectl delete ns audit-task
sudo sed -i '/audit-policy.yaml/d' /etc/kubernetes/manifests/kube-apiserver.yaml
sudo sed -i '/audit-log-path/d' /etc/kubernetes/manifests/kube-apiserver.yaml
sudo rm -f /etc/kubernetes/audit-policy.yaml
sudo rm -f /var/log/kubernetes/audit.log
