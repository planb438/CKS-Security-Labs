#!/bin/bash
echo "[+] Cleaning up..."
kubectl delete ns netpol-task access-allowed
