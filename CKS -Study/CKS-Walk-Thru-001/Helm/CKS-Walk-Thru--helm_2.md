[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)
[![Platform](https://img.shields.io/badge/platform-Ubuntu%2022.04%2B-lightgrey)](#)
[![Kubernetes](https://img.shields.io/badge/Kubernetes-MicroK8s%20%7C%20kubeadm-blue)](#)
[![YouTube](https://img.shields.io/badge/YouTube-TechShorts-red)](https://www.youtube.com/@adaribain)
[![LinkedIn](https://img.shields.io/badge/LinkedIn-Adari%20Bain-blue)](https://www.linkedin.com/in/adari-bain-298924152/)

## helm

1. Helm: Installed, Used for App Deployment

Purpose
Helm is a package manager for Kubernetes. It simplifies deploying and managing applications via reusable "charts."

Setup Checklist
1. Install Helm (on control plane node):



curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash



2. Verify Installation:



helm version



3. Add Chart Repositories: Example:



helm repo add bitnami https://charts.bitnami.com/bitnami
helm repo update



4. Deploy a Helm Chart (Node App Example):



helm install node-app ./my-node-chart --namespace dev --create-namespace



5. Use Values.yaml for Customization: Helm lets you override chart defaults via --values or -f values.yaml.

Security Best Practices

| Practice | Explanation |
| Use --namespace with Helm | Prevents cross-namespace clutter/conflicts |
| Avoid Tiller (Helm v2) | Helm v3 is client-side, no server, safer |
| Store secrets in sealed-secrets or external-secrets | Avoid putting secrets directly in values.yaml |
| Restrict RBAC for Helm users | Create dedicated service accounts with minimal permissions |




Verification



helm list -n dev
kubectl get all -n dev



 What You Should Remember
• Use Helm to deploy, upgrade, and rollback apps.

• Keep values.yaml parameterized and version-controlled.

• Helm improves DRYness, repeatability, and auditing in Kubernetes deployments




