[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)
[![Platform](https://img.shields.io/badge/platform-Ubuntu%2022.04%2B-lightgrey)](#)
[![Kubernetes](https://img.shields.io/badge/Kubernetes-MicroK8s%20%7C%20kubeadm-blue)](#)
[![YouTube](https://img.shields.io/badge/YouTube-TechShorts-red)](https://www.youtube.com/@adaribain)
[![LinkedIn](https://img.shields.io/badge/LinkedIn-Adari%20Bain-blue)](https://www.linkedin.com/in/adari-bain-298924152/)

🧠 Scenario 2: Block Privileged Pods Using OPA Gatekeeper (Rego-Based)
---

📘 Real-World Context

-

Your organization uses OPA Gatekeeper to enforce Kubernetes policies across teams. You want to block pods running with privileged: true, similar to the Kyverno rule — but using Rego and CRDs.

-

🎯 Objectives
Install OPA Gatekeeper via official manifests

-
Apply a ConstraintTemplate (defines the Rego logic)

Apply a Constraint (applies the logic to pod resources)

Test it with a violating pod

See how Rego policies work in a real admission controller

-

📁 Files:
bash
Copy
Edit
cks-labs/
└── 02-opa-gatekeeper/
    ├── install-gatekeeper.sh
    ├── privileged-container-template.yaml
    ├── privileged-container-constraint.yaml
    ├── test-bad-pod.yaml
    └── README.md

---


✅ Verification
-
kubectl apply -f test-bad-pod.yaml

-
Expected output:
-
Error from server: admission webhook \"...\" denied the request: Privileged containers are not allowed

---

📘 README.md Summary

# 🚫 OPA Gatekeeper: Block Privileged Pods

This lab installs OPA Gatekeeper and uses a Rego-based policy to block pods using privileged mode.

## ✅ What You Do
---

- Install Gatekeeper using official manifests
- Define a `ConstraintTemplate` using Rego
- Apply a `Constraint` to match pod resources

- Test with a violating pod
---

## 🤔 Why This Matters

---
  OPA Gatekeeper is heavily used in enterprises
  -
  Rego policies allow advanced logic and auditing
  -
  CKS often includes admission control tasks
  
---
## 🔍 Test
```bash
kubectl apply -f test-bad-pod.yaml
Should be rejected by webhook: "Privileged containers are not allowed"

🔄 Cleanup
bash
Copy
Edit
kubectl delete -f privileged-container-constraint.yaml
kubectl delete -f privileged-container-template.yaml
kubectl delete -f test-bad-pod.yaml
kubectl delete ns gatekeeper-system


---

You're seeing a classic OPA Gatekeeper webhook failure — and it’s highly relevant to CKS because admission webhooks are critical control points that can break cluster usability when misconfigured.
-
❌ Problem Summary
pgsql
Copy
Edit
Error from server: failed calling webhook "check-ignore-label.gatekeeper.sh":
Post "https://gatekeeper-webhook-service.gatekeeper-system.svc:443/...":
service "gatekeeper-webhook-service" not found
This means:

Gatekeeper's webhook service is either not running, crashed, or not created yet

You're trying to create a resource (namespace) that triggers the webhook, but the webhook backend is unavailable

✅ Fixes and Workaround Options
🔎 1. Check Gatekeeper Pod Status
bash
Copy
Edit
kubectl get pods -n gatekeeper-system
kubectl describe pod -n gatekeeper-system gatekeeper-controller-*
Look for:

CrashLoopBackOff

Image pull errors

Missing TLS cert volume mounts

🛠 2. Confirm the Webhook Service Exists
bash
Copy
Edit
kubectl get svc -n gatekeeper-system
You should see:

css
Copy
Edit
gatekeeper-webhook-service   ClusterIP   10.x.x.x   <none>   443/TCP
If not:

The deployment likely failed to create it

Try reapplying the manifest:

bash
Copy
Edit
kubectl delete -f https://raw.githubusercontent.com/open-policy-agent/gatekeeper/release-3.15/deploy/gatekeeper.yaml
sleep 5
kubectl apply -f https://raw.githubusercontent.com/open-policy-agent/gatekeeper/release-3.15/deploy/gatekeeper.yaml
💡 Optional: Temporarily Remove Gatekeeper Webhook Config
If the cluster is stuck and you urgently need to restore functionality (not for CKS exam):

bash
Copy
Edit
kubectl delete validatingwebhookconfiguration gatekeeper-validating-webhook-configuration
This disables Gatekeeper’s webhook, allowing you to use the cluster again, but you’ll lose policy enforcement until it’s reinstalled.

🧠 CKS Tip
Admission controllers (Kyverno, Gatekeeper, custom webhooks) can block core operations if they fail. Always:

Monitor their health

Test in dedicated namespaces (dev, test)

Know how to safely disable them when debugging








    
