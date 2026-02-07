[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)
[![Platform](https://img.shields.io/badge/platform-Ubuntu%2022.04%2B-lightgrey)](#)
[![Kubernetes](https://img.shields.io/badge/Kubernetes-MicroK8s%20%7C%20kubeadm-blue)](#)
[![YouTube](https://img.shields.io/badge/YouTube-TechShorts-red)](https://www.youtube.com/@adaribain)
[![LinkedIn](https://img.shields.io/badge/LinkedIn-Adari%20Bain-blue)](https://www.linkedin.com/in/adari-bain-298924152/)


# CKS-Walk-Thru-003

# ✅ Top 15 Most Exam-Aligned CKS Practice Questions 

These questions were selected from the uploaded CKS exam dump PDF, filtered and ranked for alignment with the **latest CNCF CKS curriculum**, based on Kubernetes 1.27+ and real exam relevance. Deprecated features (e.g., PodSecurityPolicy) and off-topic questions were excluded.

---

### 🥇 1. **ServiceAccount & RBAC Least Privilege**

**Question**: Create a ServiceAccount and bind a Role to allow only listing pods in a namespace.

> ✅ Core RBAC task. Aligned with Cluster Hardening & Access Control topics.

---

### 🥈 2. **Audit Logging & Advanced Policy Rules**

**Question**: Enable audit logs, configure log rotation, and define custom rules to log sensitive events.

> ✅ Appears nearly verbatim on actual exam. Key for Observability domain.

---

### 🥉 3. **NetworkPolicy for Namespace + Label Selector Access**

**Question**: Create a NetworkPolicy to allow traffic only from certain namespaces and pods with specific labels.

> ✅ Classic network isolation task. High chance of appearing.

---

### 4. **Secrets Encryption at Rest**

**Question**: Configure etcd secret encryption using AES-CBC and verify with etcdctl.

> ✅ Very likely to appear. Critical for Supply Chain Security.

---

### 5. **Falco Runtime Threat Detection**

**Question**: Analyze container activity using Falco for runtime threat detection.

> ✅ Runtime monitoring is exam-critical. Strong real-world relevance.

---

### 6. **Kyverno verifyImages + Cosign Integration**

**Question**: Enable image signature verification using a policy and deny unsigned images.

> ✅ Newer curriculum focus. Requires Kyverno + Cosign setup.

---

### 7. **Restrict Privileged Pods (PodSecurity Admission)**

**Question**: Block privileged containers and host networking via PSA or policies.

> ✅ Simple but must-know use of PSA / Kyverno. Guaranteed exam appearance.

---

### 8. **Image Scanning with Trivy**

**Question**: Scan images for HIGH/CRITICAL vulnerabilities and take action.

> ✅ Strongly aligned with Supply Chain + Risk Mitigation.

---

### 9. **Syft + Grype: SBOM + Image Vulnerability Detection**

**Question**: Generate SBOM using Syft and scan for CVEs with Grype.

> ✅ SBOM focus is growing. Excellent hands-on example.

---

### 10. **Restrict ServiceAccount Token Auto-Mounting**

**Question**: Prevent token mounting in pods or via SA configuration.

> ✅ Subtle detail often tested. Covered in Cluster Hardening domain.

---

### 11. **Admission Controller Configuration: API Server Hardening**

**Question**: Enable RBAC, Webhook mode, and disable anonymous auth.

> ✅ Classic kube-bench findings. Exam blueprint match.

---

### 12. **Create AppArmor Profile + Restrict Write Access**

**Question**: Apply an AppArmor profile that denies file writes.

> ✅ Strong system-level hardening test. Moderate to high frequency.

---

### 13. **Limit Pod Capabilities (Drop ALL, No NET\_RAW)**

**Question**: Write securityContext that removes all capabilities + blocks NET\_RAW.

> ✅ Easy to test. Usually appears as part of pod YAML analysis.

---

### 14. **Use RuntimeClass to Apply gVisor Isolation**

**Question**: Create a RuntimeClass and run a pod using `runsc` handler.

> ⚠️ Moderate frequency. Worth knowing for sandboxing containers.

---

### 15. **Restrict Image Tag Usage (Deny `:latest`)**

**Question**: Deny use of unpinned image tags (e.g., `nginx:latest`) using admission policy.

> ✅ Common supply chain practice. Appears in Kyverno- or Gatekeeper-based exams.

---

### ❌ Not Included:

* PodSecurityPolicy (PSP) based tasks — deprecated since 1.25
* Outdated Dockerfile syntax or unsafe base images (not exam-critical)
* Ansible/Terraform references — out of scope for CKS

---

Would you like YAML templates or lab examples for any of the Top 15 questions above?
