# 🚫 OPA Gatekeeper: Block Privileged Pods

---

This lab installs OPA Gatekeeper and uses a Rego-based policy to block pods using privileged mode.

---

## ✅ What You Do

- Install Gatekeeper using official manifests
- Define a `ConstraintTemplate` using Rego
- Apply a `Constraint` to match pod resources
- Test with a violating pod
---
## 🤔 Why This Matters
- OPA Gatekeeper is heavily used in enterprises
- Rego policies allow advanced logic and auditing
- CKS often includes admission control tasks
---
## 🔍 Test

kubectl apply -f test-bad-pod.yaml
