### deploy.sh
#!/bin/bash

echo "[+] Creating namespace"
kubectl create ns dev

echo "[+] Installing Kyverno CRDs"
kubectl apply -f https://raw.githubusercontent.com/kyverno/kyverno/main/config/crds/kyverno-crds.yaml

echo "[+] Installing Helm chart (node app)"
helm repo add bitnami https://charts.bitnami.com/bitnami
helm repo update
helm install node-app bitnami/node -f values.yaml -n dev --create-namespace

echo "[+] Installing Kyverno"
helm repo add kyverno https://kyverno.github.io/kyverno/
helm repo update
helm install kyverno kyverno/kyverno -n kyverno --create-namespace

echo "[+] Applying Kyverno policy"
kubectl apply -f kyverno-policy.yaml


