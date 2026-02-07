[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)
[![Platform](https://img.shields.io/badge/platform-Ubuntu%2022.04%2B-lightgrey)](#)
[![Kubernetes](https://img.shields.io/badge/Kubernetes-MicroK8s%20%7C%20kubeadm-blue)](#)
[![YouTube](https://img.shields.io/badge/YouTube-TechShorts-red)](https://www.youtube.com/@adaribain)
[![LinkedIn](https://img.shields.io/badge/LinkedIn-Adari%20Bain-blue)](https://www.linkedin.com/in/adari-bain-298924152/)

🌐 Task 14.3 – NetworkPolicy: Namespace + Label-Based Access
📘 Scenario
Your security team requires strict namespace and pod-level ingress control. Only a client pod in namespace access-allowed with label access: granted may connect to a web pod in namespace netpol-task.

🎯 Objectives
Create two namespaces: netpol-task and access-allowed

Deploy a web server pod in netpol-task

Deploy a client pod in access-allowed with label access=granted

Apply a NetworkPolicy that:

Blocks all by default

Only allows ingress to web from matching client pods

Verify access and rejection with wget

📁 File Structure
bash
Copy
Edit
cks-labs/
└── 14-mock-tasks/
    └── task-03-networkpolicy/
        ├── 00-namespaces.yaml
        ├── 01-web-pod.yaml
        ├── 02-client-pod.yaml
        ├── 03-networkpolicy.yaml
        ├── test-connect.sh
        ├── cleanup.sh
        └── README.md

        ---

  📘 README.md Summary
markdown
Copy
Edit
# 🌐 Task 3 – NetworkPolicy with Namespace + Label Restriction

## 🎯 Goal
Only allow ingress to a `web` pod from pods in another namespace **with a specific label**.

## 🛠 Setup
```bash
kubectl apply -f 00-namespaces.yaml
kubectl apply -f 01-web-pod.yaml
kubectl apply -f 02-client-pod.yaml
kubectl label ns access-allowed name=access-allowed
kubectl apply -f 03-networkpolicy.yaml
🧪 Test
bash
Copy
Edit
./test-connect.sh
✅ Should succeed only if namespace + pod label matches.

💡 CKS Tip
Combine namespaceSelector and podSelector for scoped control

Defaults to deny once a NetworkPolicy is applied

Use DNS-based svc name (web.netpol-task.svc) in client pod      
