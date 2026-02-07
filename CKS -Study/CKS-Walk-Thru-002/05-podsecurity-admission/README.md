[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)
[![Platform](https://img.shields.io/badge/platform-Ubuntu%2022.04%2B-lightgrey)](#)
[![Kubernetes](https://img.shields.io/badge/Kubernetes-MicroK8s%20%7C%20kubeadm-blue)](#)
[![YouTube](https://img.shields.io/badge/YouTube-TechShorts-red)](https://www.youtube.com/@adaribain)
[![LinkedIn](https://img.shields.io/badge/LinkedIn-Adari%20Bain-blue)](https://www.linkedin.com/in/adari-bain-298924152/)

# 🔐 PodSecurity Admission: Restricted Profile

🔐 Scenario 5: PodSecurity Admission – Enforce Restricted Profile
📘 Real-World Context
Kubernetes 1.25+ uses PodSecurity Admission (PSA) to enforce security standards like restricted, baseline, and privileged. As a cluster security admin, your job is to configure PSA to enforce restricted mode, ensuring all pods meet strict security requirements by default.

🎯 Objectives
Enable PSA labels on a namespace

Deploy an insecure pod — it should be blocked

Deploy a restricted-compliant pod — it should pass

📁 Files
bash
Copy
Edit
cks-labs/
└── 05-podsecurity-admission/
    ├── ns-restricted.yaml
    ├── bad-pod.yaml
    ├── good-pod.yaml
    └── README.md

---

    💡 CKS Tips
    -
    
PSA is native in K8s 1.25+ — no admission webhook needed. Combine with Kyverno for flexible, custom policy enforcement

    ---

## 🧠 What This Is
PodSecurity Admission (PSA) is a built-in controller that enforces security best practices for pods using namespace labels.

## ✅ Goal
Block insecure pods in a namespace by labeling it with `restricted` mode.

## 🧪 Test
```bash
kubectl apply -f ns-restricted.yaml
kubectl apply -f bad-pod.yaml    # ❌ should be rejected
kubectl apply -f good-pod.yaml   # ✅ should be allowed
