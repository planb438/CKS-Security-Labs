[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)
[![Platform](https://img.shields.io/badge/platform-Ubuntu%2022.04%2B-lightgrey)](#)
[![Kubernetes](https://img.shields.io/badge/Kubernetes-MicroK8s%20%7C%20kubeadm-blue)](#)
[![YouTube](https://img.shields.io/badge/YouTube-TechShorts-red)](https://www.youtube.com/@adaribain)
[![LinkedIn](https://img.shields.io/badge/LinkedIn-Adari%20Bain-blue)](https://www.linkedin.com/in/adari-bain-298924152/)

🔐 Task 14.4 – Cosign + Kyverno verifyImages Policy Enforcement
📘 Scenario
Your organization only allows images that are signed using Cosign. You need to configure Kyverno to deny all unsigned images, using a provided public key stored securely in a Kubernetes Secret.

🎯 Objectives
Create a namespace verify-task

Store your Cosign public key in a Secret (cosign-pubkey)

Write a Kyverno ClusterPolicy using verifyImages to enforce image signatures

Test:

✅ A signed image is accepted

❌ An unsigned image is denied

📁 File Structure
bash
Copy
Edit
cks-labs/
└── 14-mock-tasks/
    └── task-04-cosign-verifyimages/
        ├── 00-namespace.yaml
        ├── 01-pubkey-secret.sh
        ├── 02-verify-policy.yaml
        ├── 03-signed-pod.yaml
        ├── 04-unsigned-pod.yaml
        ├── cleanup.sh
        └── README.md


---

📘 README.md Summary
markdown
Copy
Edit
# 🔐 Task 4 – Kyverno verifyImages + Cosign Signature Enforcement

## 🎯 Goal
Only allow signed container images in the cluster, using Kyverno with a public Cosign key.

## 🛠 Steps
```bash
kubectl apply -f 00-namespace.yaml
./01-pubkey-secret.sh
kubectl apply -f 02-verify-policy.yaml
kubectl apply -f 03-signed-pod.yaml     # ✅ Allowed
kubectl apply -f 04-unsigned-pod.yaml   # ❌ Blocked
💡 CKS Tip
Use keyRef with a Secret for better security

Enable mutateDigest to enforce immutable deploys

Signed images must be pushed and signed by you

yaml
Copy
Edit
