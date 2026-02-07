    
#!/bin/bash

echo "[+] Cleaning up NetworkPolicy lab..."
kubectl delete ns np-demo --ignore-not-found
kubectl delete ns frontend --ignore-not-found