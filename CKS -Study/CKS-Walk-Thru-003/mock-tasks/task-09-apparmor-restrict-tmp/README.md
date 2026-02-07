[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)
[![Platform](https://img.shields.io/badge/platform-Ubuntu%2022.04%2B-lightgrey)](#)
[![Kubernetes](https://img.shields.io/badge/Kubernetes-MicroK8s%20%7C%20kubeadm-blue)](#)
[![YouTube](https://img.shields.io/badge/YouTube-TechShorts-red)](https://www.youtube.com/@adaribain)
[![LinkedIn](https://img.shields.io/badge/LinkedIn-Adari%20Bain-blue)](https://www.linkedin.com/in/adari-bain-298924152/)

🛡️ Task 14.9 – AppArmor Profile to Restrict File Access
📘 Scenario
You are asked to restrict a container from writing to the /tmp directory using an AppArmor profile. This must be enforced via Kubernetes.

🎯 Objectives
Write a custom AppArmor profile that blocks writes to /tmp

Load the profile on the host

Annotate a pod to apply the profile

Confirm that writes to /tmp fail

📁 File Structure
bash
Copy
Edit
cks-labs/
└── 14-mock-tasks/
    └── task-09-apparmor-restrict-tmp/
        ├── 00-apparmor-profile
        ├── 01-load-profile.sh
        ├── 02-pod-restricted.yaml
        ├── 03-test-write.sh
        ├── cleanup.sh
        └── README.md

---

📘 README.md Summary
markdown
Copy
Edit
# 🛡️ Task 9 – AppArmor: Restrict Writes to /tmp

## 🎯 Goal
Prevent container from writing to /tmp using a host-level AppArmor profile.

## 🧱 Key Steps
- Load profile with `apparmor_parser`
- Apply with pod annotation: `container.apparmor.security.beta.kubernetes.io/<container>: localhost/deny-tmp`

## 🛠 Deploy
```bash
./01-load-profile.sh
kubectl apply -f 02-pod-restricted.yaml
🔍 Test
bash
Copy
Edit
./03-test-write.sh
✅ Output should include: DENIED

💡 CKS Tip
AppArmor must be enabled on the host

Only works on containerd/CRI-O with Ubuntu/Debian

Pod annotations apply profile to a specific container name

yaml
Copy
Edit
