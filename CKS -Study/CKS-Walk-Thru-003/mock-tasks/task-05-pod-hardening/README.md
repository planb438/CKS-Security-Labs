[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)
[![Platform](https://img.shields.io/badge/platform-Ubuntu%2022.04%2B-lightgrey)](#)
[![Kubernetes](https://img.shields.io/badge/Kubernetes-MicroK8s%20%7C%20kubeadm-blue)](#)
[![YouTube](https://img.shields.io/badge/YouTube-TechShorts-red)](https://www.youtube.com/@adaribain)
[![LinkedIn](https://img.shields.io/badge/LinkedIn-Adari%20Bain-blue)](https://www.linkedin.com/in/adari-bain-298924152/)

🔐 Task 14.5 – Pod Hardening: Prevent Privileged + NET_RAW Capability
📘 Scenario
Your team mandates that all pods must:

Run unprivileged

Have no added Linux capabilities

Explicitly drop NET_RAW to prevent raw socket abuse

🎯 Objectives
Create a pod using a securityContext that:

Does not run as root

Is not privileged

Drops ALL capabilities

Explicitly removes NET_RAW

Validate that capsh or /proc/self/status shows capabilities are dropped

📁 File Structure
bash
Copy
Edit
cks-labs/
└── 14-mock-tasks/
    └── task-05-pod-hardening/
        ├── 01-secure-pod.yaml
        ├── check-capabilities.sh
        ├── cleanup.sh
        └── README.md

        ---

     🔎 Verify
bash
Copy
Edit
./check-capabilities.sh
✅ Expect: CapEff: 0000000000000000

💡 CKS Tip
Dropping NET_RAW is often tested (prevents ICMP, raw packets)

Use allowPrivilegeEscalation: false with drop: ["ALL"]

Combine with PodSecurityAdmission or Kyverno for enforcement   
