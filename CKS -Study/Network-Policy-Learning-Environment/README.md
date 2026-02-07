[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)
[![Platform](https://img.shields.io/badge/platform-Ubuntu%2022.04%2B-lightgrey)](#)
[![Kubernetes](https://img.shields.io/badge/Kubernetes-MicroK8s%20%7C%20kubeadm-blue)](#)
[![YouTube](https://img.shields.io/badge/YouTube-TechShorts-red)](https://www.youtube.com/@adaribain)
[![LinkedIn](https://img.shields.io/badge/LinkedIn-Adari%20Bain-blue)](https://www.linkedin.com/in/adari-bain-298924152/)


# 🌐 CKS NetworkPolicy Lab

A hands-on Kubernetes NetworkPolicy lab designed for real-world CKS prep. Includes test pods, labeled namespaces, and YAML files for each policy scenario.

---

📁 Lab Structure

networkpolicy-lab/
├── 00-pods.yaml
├── allow-client-to-web.yaml
├── allow-egress-all.yaml
├── allow-from-frontend-ns.yaml
├── allow-port-80.yaml
├── allow-all-ingress.yaml
├── deny-all-egress.yaml
├── deny-all-ingress.yaml
├── combined-ingress-egress.yaml
├── dns-block-egress.yaml
├── cidr-allow.yaml
├── test-connection.sh
├── cleanup.sh
└── README.md

🚀 Deployment Steps

1. Create Namespaces & Label

kubectl create ns np-demo
kubectl label ns np-demo purpose=np-lab
kubectl create ns frontend
kubectl label ns frontend access=true

2. Deploy Demo Pods

kubectl apply -f 00-pods.yaml

3. Apply a Policy of Your Choice

kubectl apply -f deny-all-ingress.yaml          # Deny everything by default
kubectl apply -f allow-client-to-web.yaml       # Allow access only from client pod
kubectl apply -f allow-from-frontend-ns.yaml    # Allow traffic from frontend ns
kubectl apply -f allow-port-80.yaml             # Port-specific ingress
kubectl apply -f allow-egress-all.yaml          # Allow all egress from client
kubectl apply -f allow-all-ingress.yaml         # Allow all ingress traffic
kubectl apply -f deny-all-egress.yaml           # Block all egress traffic
kubectl apply -f combined-ingress-egress.yaml   # Combined ingress + egress
kubectl apply -f dns-block-egress.yaml          # Block DNS egress (test impact)
kubectl apply -f cidr-allow.yaml                # Allow from CIDR block
```

---

## 🧪 Testing Connectivity

Use the script to test access from client and blocked pods:

```bash
chmod +x test-connection.sh
./test-connection.sh
```

### test-connection.sh

```bash
#!/bin/bash

NS=np-demo
TARGET=http://web:80

echo "[+] Testing client pod access to web..."
kubectl exec -n $NS client -- wget --timeout=1 --spider $TARGET && echo "✓ Allowed" || echo "✗ Blocked"

echo "[+] Testing blocked pod access to web..."
kubectl exec -n $NS blocked -- wget --timeout=1 --spider $TARGET && echo "✓ Allowed" || echo "✗ Blocked"
```

---

## 🧼 Cleanup

```bash
chmod +x cleanup.sh
./cleanup.sh
```

### cleanup.sh

```bash
#!/bin/bash

echo "[+] Cleaning up NetworkPolicy lab..."
kubectl delete ns np-demo --ignore-not-found
kubectl delete ns frontend --ignore-not-found
```

---

## 🔐 What You Learn

| Policy File                   | Purpose                                |
| ----------------------------- | -------------------------------------- |
| `deny-all-ingress.yaml`       | Enforce deny-by-default behavior       |
| `allow-client-to-web.yaml`    | Limit access to specific pods          |
| `allow-from-frontend-ns.yaml` | Use namespaceSelector for access       |
| `allow-port-80.yaml`          | Port-level access control              |
| `allow-egress-all.yaml`       | Allow pod to access external resources |

---

## 📘 Notes

* NetworkPolicies are **namespaced**
* Test tools: `busybox`, `wget`, `curl`, `netcat`
* Policies are enforced only if **network plugins (like Calico, Cilium)** support them

---

 practicing practicing practicing !!! 🎓


✅ Summary of Common + CKS-Style NetworkPolicy Scenarios
#	Scenario	Description	YAML Ready?
1	🔐 Deny all ingress	Default deny for all pods	✅ Yes (deny-all-ingress.yaml)
2	✅ Allow all ingress	Open to all (often a baseline)	❌ (can add allow-all-ingress.yaml)
3	🎯 PodSelector	Allow from specific pods in same namespace	✅ Yes (allow-client-to-web.yaml)
4	🌍 NamespaceSelector	Allow from a specific namespace	✅ Yes (allow-from-frontend-ns.yaml)
5	🌐 Port-specific allow	Only allow traffic to specific port	✅ Yes (allow-port-80.yaml)
6	🚀 Egress allow	Allow traffic from a pod	✅ Yes (allow-egress-all.yaml)
7	🚫 Deny egress	Block all outgoing traffic	❌ (can add deny-all-egress.yaml)
8	🔄 Combined Ingress + Egress	Define both directions in a single policy	❌
9	📛 DNS resolution blocked	Egress policy blocks DNS (breaks many apps)	❌
10	🧪 CIDR Allow	Allow to IP block (e.g. 10.0.0.0/24)	❌



✅ Final Checklist of NetworkPolicy Scenarios
Category	Scenario Covered?	YAML in Lab?
🔐 Default Deny	✅ Yes	deny-all-ingress.yaml, deny-all-egress.yaml
🎯 PodSelector	✅ Yes	allow-client-to-web.yaml
🌍 NamespaceSelector	✅ Yes	allow-from-frontend-ns.yaml
🌐 Port Filter	✅ Yes	allow-port-80.yaml
🚀 Allow All Ingress	✅ Yes	allow-all-ingress.yaml
🔁 Combined Ingress/Egress	✅ Yes	combined-ingress-egress.yaml
🧱 CIDR/IP Block	✅ Yes	cidr-allow.yaml
📛 Block DNS (Egress)	✅ Yes	dns-block-egress.yaml
🌎 Allow All Egress	✅ Yes	allow-egress-all.yaml
🔁 Label + Namespace Combo	✅ Yes	already covered via frontend namespace
