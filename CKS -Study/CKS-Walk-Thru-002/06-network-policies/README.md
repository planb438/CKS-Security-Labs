[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)
[![Platform](https://img.shields.io/badge/platform-Ubuntu%2022.04%2B-lightgrey)](#)
[![Kubernetes](https://img.shields.io/badge/Kubernetes-MicroK8s%20%7C%20kubeadm-blue)](#)
[![YouTube](https://img.shields.io/badge/YouTube-TechShorts-red)](https://www.youtube.com/@adaribain)
[![LinkedIn](https://img.shields.io/badge/LinkedIn-Adari%20Bain-blue)](https://www.linkedin.com/in/adari-bain-298924152/)

🔗 Scenario 6: Network Policies – Isolate & Allow Pod Traffic
📘 Real-World Context
By default, Kubernetes allows all pods to communicate with each other. That’s insecure in multi-tenant or production environments. You need to enforce least privilege networking using NetworkPolicy.

This lab simulates:

A backend pod that should only be accessed by a frontend client

Other pods (like a busybox attacker) should be denied

🎯 Objectives
Deploy a backend service

Deploy a test client (busybox)

Apply a deny-all default NetworkPolicy

Create a policy that allows only the trusted client to access the backend

📁 Files
bash
Copy
Edit
cks-labs/
└── 06-network-policies/
    ├── 00-namespace.yaml
    ├── 01-backend-pod.yaml
    ├── 02-client-pod.yaml
    ├── 03-network-deny-all.yaml
    ├── 04-allow-client-to-backend.yaml
    ├── 05-busybox-attacker.yaml
    └── README.md

    ---


    🔍 Test Commands
bash
Copy
Edit
# Test from trusted client (should work)
kubectl exec -n netpol-test trusted-client -- curl -s backend

# Test from attacker (should fail)
kubectl exec -n netpol-test attacker -- wget -qO- backend || echo "Blocked"

-

📘 README.md Summary
markdown
Copy
Edit
# 🔗 NetworkPolicy: Isolate and Allow Traffic

## 🎯 Goal
Restrict pod communication using `NetworkPolicy` — only allow traffic from trusted pods.

## 🧪 Test
```bash
kubectl apply -f 00-namespace.yaml
kubectl apply -f 01-backend-pod.yaml
kubectl apply -f 02-client-pod.yaml
kubectl apply -f 05-busybox-attacker.yaml
kubectl apply -f 03-network-deny-all.yaml
kubectl apply -f 04-allow-client-to-backend.yaml
✅ Trusted client
bash
Copy
Edit
kubectl exec -n netpol-test trusted-client -- curl -s backend
❌ Attacker
bash
Copy
Edit
kubectl exec -n netpol-test attacker -- wget -qO- backend || echo "Blocked"
💡 CKS Tip
podSelector: {} = all pods

Always combine deny all + specific allow

busybox and curl images are great for real-time testing
