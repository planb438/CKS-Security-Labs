[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)
[![Platform](https://img.shields.io/badge/platform-Ubuntu%2022.04%2B-lightgrey)](#)
[![Kubernetes](https://img.shields.io/badge/Kubernetes-MicroK8s%20%7C%20kubeadm-blue)](#)
[![YouTube](https://img.shields.io/badge/YouTube-TechShorts-red)](https://www.youtube.com/@adaribain)
[![LinkedIn](https://img.shields.io/badge/LinkedIn-Adari%20Bain-blue)](https://www.linkedin.com/in/adari-bain-298924152/)

Here’s a short and clear README.md for the Kyverno privileged pod policy lab, including what the policy does, why it matters, and Kyverno installation context.

markdown

--

# 🛡️ Kyverno Policy: Block Privileged Pods

---

## 📌 What This Is


This lab installs [Kyverno](https://kyverno.io), a Kubernetes-native policy engine, and applies a `ClusterPolicy` that blocks any pod from running in **privileged mode**.

-

Privileged containers bypass key kernel security controls and are considered a **high-risk configuration**. Preventing them is a common real-world security control — and a frequent CKS exam scenario.

---

## 🚫 What the Policy Does

```
yaml
validate:
  message: "Privileged containers are not allowed"
  pattern:
    spec:
      containers:
        - securityContext:
            privileged: "false"

---

This Kyverno ClusterPolicy enforces that every container must have privileged: false explicitly set (or not be privileged at all). If a pod tries to run with privileged: true, admission is denied.

✅ The enforcement happens before the pod is created, via an admission controller webhook.

❓ Is Kyverno Installed by Default?
No. Kyverno is not part of Kubernetes by default. You install it manually using Helm or YAML. It runs as a controller in the kyverno namespace and uses CRDs to define Policy and ClusterPolicy objects.

🧠 Why It Matters for CKS
Admission control is a major CKS domain.

You must know how to enforce pod-level security policies.

Kyverno is easier than OPA (uses YAML instead of Rego).

Many exam tasks ask you to block hostPath, privileged, hostNetwork, etc.

✅ Verification
Try applying a privileged pod:

kubectl apply -f test-bad-pod.yaml
Expected error:


admission webhook \"...\" denied the request: Privileged containers are not allowed
🔄 Cleanup

kubectl delete -f kyverno-policy.yaml
helm uninstall kyverno -n kyverno
kubectl delete ns kyverno


---
