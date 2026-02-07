#!/bin/bash
echo "[+] Checking process capabilities inside secure pod:"
kubectl exec secure-pod -- sh -c 'cat /proc/self/status | grep CapEff'
