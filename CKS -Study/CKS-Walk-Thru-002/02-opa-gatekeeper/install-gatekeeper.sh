#!/bin/bash

echo "[+] Creating Namespace Dev"
kubectl create ns dev

echo "[+] Installing Gatekeeper"
kubectl apply -f https://raw.githubusercontent.com/open-policy-agent/gatekeeper/release-3.15/deploy/gatekeeper.yaml

echo "[+] Waiting for Gatekeeper controller to be ready..."
kubectl wait --for=condition=Available -n gatekeeper-system deployment/gatekeeper-controller --timeout=90s

echo "[+] Applying ConstraintTemplate"
kubectl apply -f privileged-container-template.yaml

echo "[+] Waiting for CRD to be registered..."
until kubectl get crd k8sdisallowedprivileged.constraints.gatekeeper.sh &>/dev/null; do
  echo "Waiting for K8sDisallowedPrivileged CRD..."
  sleep 2
done

echo "[+] Applying Constraint"
kubectl apply -f privileged-container-constraint.yaml
