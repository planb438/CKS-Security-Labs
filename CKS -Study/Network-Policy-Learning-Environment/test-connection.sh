#!/bin/bash

NS=np-demo
TARGET=http://web:80

echo "[+] Testing client pod access to web..."
kubectl exec -n $NS client -- wget --timeout=1 --spider $TARGET && echo "✓ Allowed" || echo "✗ Blocked"

echo "[+] Testing blocked pod access to web..."
kubectl exec -n $NS blocked -- wget --timeout=1 --spider $TARGET && echo "✓ Allowed" || echo "✗ Blocked"