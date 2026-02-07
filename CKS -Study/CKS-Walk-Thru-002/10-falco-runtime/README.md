[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)
[![Platform](https://img.shields.io/badge/platform-Ubuntu%2022.04%2B-lightgrey)](#)
[![Kubernetes](https://img.shields.io/badge/Kubernetes-MicroK8s%20%7C%20kubeadm-blue)](#)
[![YouTube](https://img.shields.io/badge/YouTube-TechShorts-red)](https://www.youtube.com/@adaribain)
[![LinkedIn](https://img.shields.io/badge/LinkedIn-Adari%20Bain-blue)](https://www.linkedin.com/in/adari-bain-298924152/)


🐺 Scenario 11: Falco Runtime Threat Detection
📘 Real-World Context
Kubernetes audit logs show API events, but they don’t track what happens inside containers. That’s where Falco comes in — a real-time threat detection tool that watches for suspicious activity in containers (e.g., shell exec, unexpected network use, file changes).

You’ll:

Install Falco

Trigger suspicious activity (e.g., interactive shell inside a container)

Detect it via Falco alerts (logs or events)

🎯 Objectives
Install Falco using Helm (in its own namespace)

Deploy a demo pod

Trigger activity Falco should alert on (e.g., exec into container)

View logs and validate alert

Understand CKS-relevant alerts

📁 Files
bash
Copy
Edit
cks-labs/
└── 11-falco-runtime/
    ├── 00-namespace.yaml
    ├── 01-install-falco.sh
    ├── 02-demo-pod.yaml
    ├── 03-trigger-shell.sh
    ├── 04-get-alerts.sh
    ├── cleanup.sh
    └── README.md

    ---

  📘 README.md Summary
markdown
Copy
Edit
# 🐺 Scenario 11 – Falco Runtime Detection

## 🎯 Goal
Detect suspicious activity inside containers in real time using Falco.

## ✅ What You Do
- Install Falco in its own namespace
- Deploy a test pod (`busybox`)
- Exec into the pod (Falco alert)
- Check Falco logs for warning

## 🧪 Test
```bash
./01-install-falco.sh
./03-trigger-shell.sh
./04-get-alerts.sh
💡 CKS Tip
Falco detects exec, chmod, connect, and other syscall-based behaviors

Not a replacement for audit logs — it's runtime visibility

In CKS, may be asked to investigate suspicious behavior  

---

🧠 CKS Exam Tips on Falco
exec, chmod, connect, and write are commonly flagged

Know how to read alerts, not just trigger them

Falco logs go to the pod logs by default (or sidekick / file output if configured)
