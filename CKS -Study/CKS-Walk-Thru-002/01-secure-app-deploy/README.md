[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)
[![Platform](https://img.shields.io/badge/platform-Ubuntu%2022.04%2B-lightgrey)](#)
[![Kubernetes](https://img.shields.io/badge/Kubernetes-MicroK8s%20%7C%20kubeadm-blue)](#)
[![YouTube](https://img.shields.io/badge/YouTube-TechShorts-red)](https://www.youtube.com/@adaribain)
[![LinkedIn](https://img.shields.io/badge/LinkedIn-Adari%20Bain-blue)](https://www.linkedin.com/in/adari-bain-298924152/)

### README.md
Excellent — since your Kubernetes cluster is already up, we’ll start from that point and build a realistic, exam-aligned workflow using:
-

✅ Helm (for app deployment)

-

🔐 Kyverno (YAML-native policy enforcement)

-

🧠 OPA Gatekeeper (Rego-based advanced policies)

-

We'll structure the flow like practical CKS scenarios, assuming nothing else is installed (Helm, Kyverno, OPA, etc.), and we’ll build one lab at a time.

---

🔰 Scenario 1: Deploy and Harden a Node.js App Using Helm + Kyverno
📘 Real-World Context:
Your dev team wants to deploy a Node.js app using Helm. Your job as the security-focused admin is to:

Deploy it into an isolated namespace

Harden it using liveness/readiness probes and resource limits

Enforce policies via Kyverno to prevent insecure pods

---

🎯 Objectives:
Install Helm (if not already)

Create a new namespace (dev)

Deploy the app with probes + limits via values.yaml

Install Kyverno

Apply a policy that blocks privileged pods

Try to violate the policy and verify enforcement

---

📁 Structure:
bash
Copy
Edit
cks-labs/
└── 01-secure-app-deploy/
    ├── values.yaml
    ├── deploy.sh
    ├── kyverno-policy.yaml
    ├── test-bad-pod.yaml
    └── README.md


---

🧪 Test & Verify


# Verify Kyverno policy blocks the bad pod
kubectl apply -f test-bad-pod.yaml


Expected:


Error from server: admission webhook \"...\" denied the request: Privileged containers are not allowed

---

✅ CKS Tips:
• Kyverno is YAML-native and great for pod-level rules

• Use ClusterPolicy for cluster-wide coverage

• Use kubectl -n kyverno logs to troubleshoot policies

---

🔄 Cleanup

---

helm uninstall node-app -n dev
helm uninstall kyverno -n kyverno
kubectl delete ns dev kyverno





