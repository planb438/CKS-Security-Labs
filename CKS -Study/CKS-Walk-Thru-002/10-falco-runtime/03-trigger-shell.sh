#!/bin/bash
kubectl apply -f 00-namespace.yaml
kubectl apply -f 02-demo-pod.yaml

echo "[+] Waiting for pod to be ready..."
kubectl wait --for=condition=Ready pod/busybox -n falco-test --timeout=30s

echo "[!] Executing into container (triggers Falco alert)..."
kubectl exec -n falco-test busybox -- sh -c "echo 'Simulating suspicious exec'; sleep 2"
