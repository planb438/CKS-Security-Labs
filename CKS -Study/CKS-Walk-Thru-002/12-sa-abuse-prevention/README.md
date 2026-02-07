[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)
[![Platform](https://img.shields.io/badge/platform-Ubuntu%2022.04%2B-lightgrey)](#)
[![Kubernetes](https://img.shields.io/badge/Kubernetes-MicroK8s%20%7C%20kubeadm-blue)](#)
[![YouTube](https://img.shields.io/badge/YouTube-TechShorts-red)](https://www.youtube.com/@adaribain)
[![LinkedIn](https://img.shields.io/badge/LinkedIn-Adari%20Bain-blue)](https://www.linkedin.com/in/adari-bain-298924152/)

🔐 Scenario 13: Preventing Service Account Token Abuse
📘 Real-World Context
In Kubernetes, ServiceAccounts provide pod-level authentication to the API server. But:

They’re automatically mounted into every pod by default.

If compromised, an attacker can query secrets, exec into pods, or worse.

You’ll practice:

Preventing token auto-mounting

Restricting ServiceAccount use

Observing token abuse potential

🎯 Objectives
Deploy a pod with a mounted ServiceAccount token

Exploit the token (e.g. access API from inside pod)

Patch to disable automountServiceAccountToken

Validate the token is gone

(Optional) Restrict access using RBAC

📁 Structure
bash
Copy
Edit
cks-labs/
└── 13-sa-abuse-prevention/
    ├── 00-namespace.yaml
    ├── 01-exploitable-pod.yaml
    ├── 02-sa-restricted.yaml
    ├── 03-pod-restricted.yaml
    ├── 04-rbac-limit.yaml
    ├── check-token.sh
    ├── README.md

    ---

   📘 README.md Summary
markdown
Copy
Edit
# 🔐 Scenario 13 – Service Account Abuse Prevention

## 🎯 Goal
Prevent pod tokens from being auto-mounted and exploited.

## ✅ Test Flow
1. Deploy default pod → token present
2. Deploy restricted pod with no token
3. (Optional) Use RBAC to limit what token can do

## 🧪 Test
```bash
kubectl apply -f 00-namespace.yaml
kubectl apply -f 01-exploitable-pod.yaml
./check-token.sh   # ✅ Should list token files

kubectl apply -f 02-sa-restricted.yaml
kubectl apply -f 03-pod-restricted.yaml
kubectl exec -n sa-test hardened -- ls /var/run/secrets/kubernetes.io/serviceaccount/   # ❌ Should be empty
💡 CKS Tip
Disable tokens: automountServiceAccountToken: false (in Pod or SA)

Always apply RBAC to limit access scope

Tokens allow API access — they must be controlled tightly

yaml
Copy
Edit
 
