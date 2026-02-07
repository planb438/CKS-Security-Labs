[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)
[![Platform](https://img.shields.io/badge/platform-Ubuntu%2022.04%2B-lightgrey)](#)
[![Kubernetes](https://img.shields.io/badge/Kubernetes-MicroK8s%20%7C%20kubeadm-blue)](#)
[![YouTube](https://img.shields.io/badge/YouTube-TechShorts-red)](https://www.youtube.com/@adaribain)
[![LinkedIn](https://img.shields.io/badge/LinkedIn-Adari%20Bain-blue)](https://www.linkedin.com/in/adari-bain-298924152/)

🔍 Scenario 09: Audit Logging & Incident Forensics
📘 Real-World Context
Your cluster must record who did what and when — especially when investigating incidents or suspicious access. Kubernetes provides audit logging, which logs all requests sent to the API server and can be filtered with fine-grained rules.

In this lab, you’ll:

Enable audit logging on the control plane

Define a policy that logs secret access

Trigger a test (access a Secret)

Inspect the log to confirm traceability

🎯 Objectives
Create an audit policy that logs secrets access

Patch the API server to use this policy

Trigger a secret read

Check the audit log for the event

Understand audit event structure (user, action, timestamp)

📁 Files
bash
Copy
Edit
cks-labs/
└── 09-audit-logs/
    ├── audit-policy.yaml
    ├── patch-apiserver.sh
    ├── trigger-access.sh
    ├── inspect-audit-log.sh
    ├── test-secret.yaml
    ├── README.md


---

🔍 inspect-audit-log.sh
bash
Copy
Edit
#!/bin/bash
echo "[+] Searching for secret access in audit log"
sudo grep test-audit /var/log/kubernetes/audit.log | jq .
✅ You’ll see an entry like:

json
Copy
Edit
{
  "user": {
    "username": "system:admin"
  },
  "verb": "get",
  "objectRef": {
    "resource": "secrets",
    "name": "test-audit",
    "namespace": "default"
  }
}

📘 README.md Summary
markdown
Copy
Edit
# 🔍 Scenario 10 – Kubernetes API Audit Logging

## 🎯 Goal
Enable audit logging to track access to Secrets and detect suspicious API activity.

## ✅ What You Do
- Define a policy that logs all `secrets` access
- Patch the API server to use the policy
- Trigger an access event
- Parse `/var/log/kubernetes/audit.log`

## 🔎 Test Steps
```bash
./patch-apiserver.sh
./trigger-access.sh
./inspect-audit-log.sh
💡 CKS Tips
Audit logs are essential for forensics

Exam may ask you to detect reads, deletions, or exec into pods

You can filter logs by verb, user, namespace, or resource
