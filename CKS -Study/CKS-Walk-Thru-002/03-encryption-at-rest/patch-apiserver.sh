#!/bin/bash

echo "[+] Copying encryption config to /etc/kubernetes"
sudo cp encryption-config.yaml /etc/kubernetes/

echo "[+] Backing up kube-apiserver manifest"
sudo cp /etc/kubernetes/manifests/kube-apiserver.yaml /etc/kubernetes/manifests/kube-apiserver.yaml.bak

echo "[+] Patching kube-apiserver to use EncryptionConfiguration"
sudo sed -i '/- --secure-port=6443/a \    - --encryption-provider-config=/etc/kubernetes/encryption-config.yaml' /etc/kubernetes/manifests/kube-apiserver.yaml

echo "[+] kube-apiserver will auto-restart via static pod"
