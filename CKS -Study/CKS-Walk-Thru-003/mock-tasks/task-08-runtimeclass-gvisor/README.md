[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)
[![Platform](https://img.shields.io/badge/platform-Ubuntu%2022.04%2B-lightgrey)](#)
[![Kubernetes](https://img.shields.io/badge/Kubernetes-MicroK8s%20%7C%20kubeadm-blue)](#)
[![YouTube](https://img.shields.io/badge/YouTube-TechShorts-red)](https://www.youtube.com/@adaribain)
[![LinkedIn](https://img.shields.io/badge/LinkedIn-Adari%20Bain-blue)](https://www.linkedin.com/in/adari-bain-298924152/)

🧱 Task 14.8 – Sandbox Isolation with RuntimeClass (gVisor)
📘 Scenario
Your cluster has gVisor installed as an alternative container runtime. You need to ensure sensitive workloads are isolated using it via a RuntimeClass.

🎯 Objectives
Create a RuntimeClass named gvisor with handler runsc

Deploy a pod that uses the RuntimeClass

Verify the RuntimeClass is applied correctly

📁 File Structure
bash
Copy
Edit
cks-labs/
└── 14-mock-tasks/
    └── task-08-runtimeclass-gvisor/
        ├── 01-runtimeclass.yaml
        ├── 02-pod-gvisor.yaml
        ├── 03-verify.sh
        ├── cleanup.sh
        └── README.md
⚠️ Pre-check: Is gVisor Installed?
Check for the runsc binary or containerd config:

bash
Copy
Edit
which runsc
If you don’t have gVisor installed, we can simulate the task with a stub RuntimeClass (see below).

---


📘 README.md Summary
markdown
Copy
Edit
# 🧱 Task 8 – Isolate Pods with gVisor via RuntimeClass

## 🎯 Goal
Use RuntimeClass to run a pod with gVisor for kernel-level sandboxing.

## 🧠 RuntimeClass
Tells the container runtime (like containerd) to use an alternative handler like `runsc`.

## ⚠️ Prerequisite
gVisor (`runsc`) must be installed and configured with containerd.

## 🛠 Steps
```bash
kubectl apply -f 01-runtimeclass.yaml
kubectl apply -f 02-pod-gvisor.yaml
🔍 Verify
bash
Copy
Edit
./03-verify.sh
✅ Output: gvisor

💡 CKS Tip
May show up as “configure sandboxed workloads”

gVisor protects against kernel exploits via syscall interception

yaml
Copy
Edit
