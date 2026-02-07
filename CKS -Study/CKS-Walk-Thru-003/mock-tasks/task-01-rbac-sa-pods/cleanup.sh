#!/bin/bash

echo "[+] Deleting Task 1 resources..."
kubectl delete rolebinding bind-pod-read -n task1 --ignore-not-found
kubectl delete role pod-read -n task1 --ignore-not-found
kubectl delete serviceaccount pod-reader -n task1 --ignore-not-found
kubectl delete ns task1 --ignore-not-found
