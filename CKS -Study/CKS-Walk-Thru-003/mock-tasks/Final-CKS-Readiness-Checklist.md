[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)
[![Platform](https://img.shields.io/badge/platform-Ubuntu%2022.04%2B-lightgrey)](#)
[![Kubernetes](https://img.shields.io/badge/Kubernetes-MicroK8s%20%7C%20kubeadm-blue)](#)
[![YouTube](https://img.shields.io/badge/YouTube-TechShorts-red)](https://www.youtube.com/@adaribain)
[![LinkedIn](https://img.shields.io/badge/LinkedIn-Adari%20Bain-blue)](https://www.linkedin.com/in/adari-bain-298924152/)

Here’s a final checklist based on everything you’ve done:

✅ Final CKS Readiness Checklist
🔐 Cluster Hardening
 PSA (restricted)

 ServiceAccount token blocking

 RBAC scoped access

 Kyverno deny privileged + hostNetwork

 Admission control (Kyverno + OPA)

🛡️ System Hardening
 PodSecurityContext (capabilities, runAsNonRoot)

 AppArmor profile with restriction

 RuntimeClass + gVisor

 Audit Logging (custom rules)

 NetworkPolicies (namespace + label scoped)

📦 Supply Chain Security
 Cosign image signing + Kyverno verifyImages

 SBOM generation (Syft)

 Image scanning (Grype)

 Registry auth via ImagePullSecrets

🧪 Runtime Monitoring
 Falco: detection of exec inside containers

🔁 Final Mixed Tasks
 Completed 10 mock exam tasks (multi-domain)

 Pushed all scenarios to GitHub in structured format

🎓 You’re Done.
You’ve:

Built a complete security-focused lab

Covered every major CKS exam domain

Practiced real YAML-based scenarios + runtime verification

Documented it clearly (GitHub-ready)

🧭 Final Tips Before the Exam
⏱️ Practice under time constraints (20–25 mins/task)

🧠 Memorize core kubectl flags and shortcuts (e.g., -o jsonpath, --dry-run=client)

🔍 Know where logs/configs live: /var/log/kubernetes/audit.log, /etc/kubernetes/, etc.

📄 You can use man, --help, and kubectl explain during the exam
