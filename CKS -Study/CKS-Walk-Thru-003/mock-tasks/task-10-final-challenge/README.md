🧪 Task 14.10 – Final Mixed CKS Challenge (Timed)
🕒 Recommended Time Limit: 25 minutes
📘 Scenario
A suspicious container (busybox-debugger) is deployed in the ops namespace. Your job is to harden the cluster, restrict access, and apply runtime monitoring.

🎯 Objectives (Multiple Steps)
🔐 Create a Kyverno policy to block any pod using:

hostNetwork: true

privileged: true

🛡️ Apply a PodSecurity Admission profile (restricted) to namespace ops

🔍 Enable Falco to monitor runtime behavior

🧼 Confirm no token is auto-mounted to the busybox-debugger pod

🔎 Check if the pod execs into a shell and trigger a Falco alert

📁 File Structure
bash
Copy
Edit
cks-labs/
└── 14-mock-tasks/
    └── task-10-final-challenge/
        ├── 00-namespace.yaml
        ├── 01-pod.yaml
        ├── 02-psa-label.sh
        ├── 03-kyverno-policy.yaml
        ├── 04-falco-check.sh
        ├── cleanup.sh
        └── README.md

        ---

   📘 README.md Summary (Excerpt)
markdown
Copy
Edit
# 🧪 Task 10 – Final CKS Challenge: Multi-Domain Hardening

## 🛠 What You Do
- Enforce restricted PSA profile
- Block privileged + hostNetwork usage via Kyverno
- Deploy a hardened pod without a token
- Confirm exec detection using Falco

## 🧪 Test
```bash
kubectl apply -f 00-namespace.yaml
kubectl apply -f 01-pod.yaml
./02-psa-label.sh
kubectl apply -f 03-kyverno-policy.yaml
./04-falco-check.sh
✅ Completion Criteria
Pod created successfully

Pod has no token mounted

Falco logs show exec alert

Kyverno blocks any privileged/hostNetwork pod     