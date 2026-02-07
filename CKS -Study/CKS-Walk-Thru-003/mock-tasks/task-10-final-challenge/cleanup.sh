#!/bin/bash
echo "[+] Cleaning up..."
kubectl delete ns ops --ignore-not-found
kubectl delete clusterpolicy block-host-privileged --ignore-not-found
