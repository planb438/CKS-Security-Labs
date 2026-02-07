[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)
[![Platform](https://img.shields.io/badge/platform-Ubuntu%2022.04%2B-lightgrey)](#)
[![Kubernetes](https://img.shields.io/badge/Kubernetes-MicroK8s%20%7C%20kubeadm-blue)](#)
[![YouTube](https://img.shields.io/badge/YouTube-TechShorts-red)](https://www.youtube.com/@adaribain)
[![LinkedIn](https://img.shields.io/badge/LinkedIn-Adari%20Bain-blue)](https://www.linkedin.com/in/adari-bain-298924152/)

--

Here’s your full CKS Lab Completion Checklist — covering everything you’ve worked through, organized by CKS domains and scenarios. This gives you a solid view of what’s been done and what’s left before diving into final mock tasks (Scenario 14).

--

✅ CKS Prep Lab Checklist: Completed So Far

--

🔐 1. Cluster Hardening
✅	Scenario	Description
✅	Scenario 3	Secrets Encryption at Rest (etcd) with AES-CBC key
✅	Scenario 5	PodSecurity Admission (PSA) with restricted profile
✅	Scenario 6	NetworkPolicy isolation + allow with busybox tester
✅	Scenario 13	Prevent service account token auto-mount + RBAC

--

🛡️ 2. System Hardening
✅	Scenario	Description
✅	Scenario 4	Pod Security Contexts: non-root, readOnlyRootFS, seccomp, drop caps
✅	Scenario 10	API Audit Logging with secret access tracking
✅	Scenario 11	Falco runtime detection (exec in container alerts)

--

📦 3. Supply Chain Security
✅	Scenario	Description
✅	Scenario 7	Private Registry + ImagePullSecrets
✅	Scenario 8 (revised)	Kyverno verifyImages with Cosign + Kubernetes Secret key
✅	Scenario 9	Cosign verifyImages using publicly signed image
✅	Scenario 12	SBOM generation + image scanning with Syft/Grype

--

🧩 4. Admission Control
✅	Scenario	Description
✅	Scenario 1	Kyverno: Block privileged containers
✅	Scenario 2	Gatekeeper: Rego-based deny privileged pods
✅	Scenario 8 (alt)	Kyverno: Enforce image digest references

--

🧪 5. Observability & Monitoring
✅	Scenario	Description
✅	Scenario 10	Audit policy for secret access
✅	Scenario 11	Falco detection of container shell execution

--

🔚 What’s Left?
❓	Scenario	Notes
🔜	Scenario 14	CKS Mock Exam-Style Tasks (mixed topics)
🧪	(Optional)	Kyverno custom policies: block hostPath, hostNetwork, etc.
🧪	(Optional)	OPA Gatekeeper with advanced constraint template logic
🧪	(Optional)	Admission webhook hardening (TLS, fail-closed config)

--

🎯 You’re Nearly There
✅ All core CKS domains have been covered
✅ Real-world tools and exam-ready YAMLs have been practiced
✅ You now have a structured lab repo ready to publish if desired

