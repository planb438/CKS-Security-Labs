#!/bin/bash

echo "[+] Testing connection from allowed client pod"

kubectl exec -n access-allowed client -- curl -m 3 http://web.netpol-task.svc.cluster.local
