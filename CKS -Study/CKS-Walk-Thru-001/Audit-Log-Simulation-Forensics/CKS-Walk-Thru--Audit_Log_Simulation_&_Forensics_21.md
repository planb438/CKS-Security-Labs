[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)
[![Platform](https://img.shields.io/badge/platform-Ubuntu%2022.04%2B-lightgrey)](#)
[![Kubernetes](https://img.shields.io/badge/Kubernetes-MicroK8s%20%7C%20kubeadm-blue)](#)
[![YouTube](https://img.shields.io/badge/YouTube-TechShorts-red)](https://www.youtube.com/@adaribain)
[![LinkedIn](https://img.shields.io/badge/LinkedIn-Adari%20Bain-blue)](https://www.linkedin.com/in/adari-bain-298924152/)


## Audit Log Simulation & Forensics

---

📜 PART 2: Audit Log Simulation & Forensics
Now that your cluster is running, let’s simulate and review audit logs.

---

⚙️ Step 1: Enable Audit Logging (If Not Already)
Ensure kube-apiserver has this flag (check with ps aux | grep kube-apiserver):
ini



--audit-policy-file=/etc/kubernetes/audit-policy.yaml
--audit-log-path=/var/log/kubernetes/audit.log


Use a basic policy like:



# /etc/kubernetes/audit-policy.yaml
apiVersion: audit.k8s.io/v1
kind: Policy
rules:
- level: Metadata


Then restart kube-apiserver (may require updating static pod manifest at /etc/kubernetes/manifests/kube-apiserver.yaml).

---
 
🔥 Step 2: Trigger Suspicious Events
For example:



kubectl auth can-i create clusterroles --as system:anonymous
kubectl get secrets --all-namespaces


Or apply a risky YAML like:
yaml



apiVersion: v1
kind: Pod
metadata:
  name: privileged
  namespace: dev
spec:
  containers:
  - name: shell
    image: busybox
    command: ["sleep", "3600"]
    securityContext:
      privileged: true

---


🔎 Step 3: Analyze Logs
View audit logs on the control plane node:
bash



sudo cat /var/log/kubernetes/audit.log | less


Search for:
• create events for pods, secrets

• userAgent fields

• as or impersonatedUser


You’re now practicing forensics!
Would you like to try simulating a malicious container action and watch Falco + audit logs react next?


