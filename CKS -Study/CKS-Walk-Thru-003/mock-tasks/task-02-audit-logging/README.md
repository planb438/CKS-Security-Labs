[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)
[![Platform](https://img.shields.io/badge/platform-Ubuntu%2022.04%2B-lightgrey)](#)
[![Kubernetes](https://img.shields.io/badge/Kubernetes-MicroK8s%20%7C%20kubeadm-blue)](#)
[![YouTube](https://img.shields.io/badge/YouTube-TechShorts-red)](https://www.youtube.com/@adaribain)
[![LinkedIn](https://img.shields.io/badge/LinkedIn-Adari%20Bain-blue)](https://www.linkedin.com/in/adari-bain-298924152/)

Great — let’s dive into Task 2: Audit Logging with a Custom Rule, a realistic CKS-style challenge that tests your knowledge of both observability and API server hardening.

🕵️ Task 14.2 – Audit Logging: Log Secret Access
📘 Scenario
You are a Kubernetes security engineer tasked with ensuring all access to Secrets in the audit-task namespace is logged by the API server.

🎯 Objectives
Define an audit policy that logs all access (GET, LIST, DELETE) to Secrets in the audit-task namespace

Configure the API server to use this audit policy (via static pod manifest patch)

Create a Secret and access it via kubectl

Verify audit logs include the event

📁 File Structure
bash
Copy
Edit
cks-labs/
└── 14-mock-tasks/
    └── task-02-audit-logging/
        ├── 00-namespace.yaml
        ├── audit-policy.yaml
        ├── patch-apiserver.sh
        ├── test-secret.yaml
        ├── trigger-access.sh
        ├── inspect-log.sh
        ├── cleanup.sh
        └── README.md

        ---

     📘 README.md Summary (Excerpt)
markdown
Copy
Edit
# 🕵️ Task 2 – Audit Logging for Secret Access

## 🎯 Goal
Log all access (e.g. GET, LIST) to Secrets in the `audit-task` namespace using Kubernetes audit logging.

---

## 🧱 Setup Files
- `audit-policy.yaml` – logs all `secrets` activity in `audit-task`
- `patch-apiserver.sh` – adds audit policy and log config to API server
- `test-secret.yaml` – sample secret to trigger an event
- `trigger-access.sh` – simulates access using kubectl
- `inspect-log.sh` – checks `/var/log/kubernetes/audit.log` for evidence
- `cleanup.sh` – removes audit config and test resources

---

## 🚀 Deployment & Test Instructions

### Step 1: Apply Audit Policy
```bash
sudo mkdir -p /var/log/kubernetes/
sudo cp audit-policy.yaml /etc/kubernetes/

---

Step 2: Patch the API Server
bash
Copy
Edit
./patch-apiserver.sh
✅ The kube-apiserver will restart automatically via static pod update.

Step 3: Trigger a Secret Access
bash
Copy
Edit
./trigger-access.sh
Step 4: View the Audit Log
bash
Copy
Edit
./inspect-log.sh
Look for entries like:

json
Copy
Edit
{
  "user": { "username": "system:admin" },
  "verb": "get",
  "objectRef": {
    "resource": "secrets",
    "namespace": "audit-task",
    "name": "demo-secret"
  }
}
🧼 Cleanup
bash
Copy
Edit
./cleanup.sh
💡 CKS Exam Tips
Always restart kube-apiserver by editing the static pod YAML

Target specific namespaces for precise audit logging

You may be asked to log create, delete, or exec instead of get

yaml
Copy
Edit
