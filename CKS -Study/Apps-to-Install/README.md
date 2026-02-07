[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)
[![Platform](https://img.shields.io/badge/platform-Ubuntu%2022.04%2B-lightgrey)](#)
[![Kubernetes](https://img.shields.io/badge/Kubernetes-MicroK8s%20%7C%20kubeadm-blue)](#)
[![YouTube](https://img.shields.io/badge/YouTube-TechShorts-red)](https://www.youtube.com/@adaribain)
[![LinkedIn](https://img.shields.io/badge/LinkedIn-Adari%20Bain-blue)](https://www.linkedin.com/in/adari-bain-298924152/)



Here’s a curated list of real-world applications you can deploy in your home lab Kubernetes cluster, ranging from developer tools to self-hosted services and monitoring systems. All can be installed via Helm or kubectl:

---

🛠️ Developer & DevOps Tools
Application	Use Case	Install Method

-Argo CD	GitOps Continuous Deployment	helm install argocd argo/argo-cd

-Jenkins	CI/CD Pipelines	helm install jenkins jenkins/jenkins

-Gitea	Self-hosted GitHub alternative	helm install gitea gitea-charts/gitea

-Harbor	Private Docker Registry	helm install harbor harbor/harbor

-Tekton	Cloud-Native CI/CD	kubectl apply -f https://storage.googleapis.com/tekton-releases/pipeline/latest/release.yaml

---

📊 Monitoring & Logging
Application	Use Case	Install Method

-Prometheus + Grafana	Monitoring & Alerts	helm install prometheus prometheus-community/kube-prometheus-stack

-Loki	Log Aggregation (like ELK)	helm install loki grafana/loki-stack

-Elasticsearch + Kibana	Search & Analytics	helm install elasticsearch elastic/elasticsearch

-OpenTelemetry	Distributed Tracing	helm install opentelemetry open-telemetry/opentelemetry-collector

---
🏠 Self-Hosted Services
Application	Use Case	Install Method

-Nextcloud	Google Drive Alternative	helm install nextcloud nextcloud/nextcloud

-Jellyfin	Self-hosted Netflix (Media Server)	helm install jellyfin jellyfin/jellyfin

-Home Assistant	IoT Automation	helm install home-assistant home-assistant/home-assistant

-Bitwarden	Self-hosted Password Manager	helm install bitwarden bitwarden/bitwarden


---
📡 Networking & Security
Application	Use Case	Install Method

-Traefik	Ingress Controller (Reverse Proxy)	helm install traefik traefik/traefik

-Cert-Manager	Automated SSL Certificates (Let’s Encrypt)	helm install cert-manager jetstack/cert-manager

-Keycloak	Identity & Access Management (IAM)	helm install keycloak bitnami/keycloak

-Pi-hole	Network-wide Ad Blocker	helm install pihole mojo2600/pihole-kubernetes

---
🤖 AI/ML & Data Processing
Application	Use Case	Install Method

-JupyterHub	Cloud Notebooks for Data Science	helm install jupyterhub jupyterhub/jupyterhub

-MLflow	Machine Learning Experiment Tracking	helm install mlflow community-charts/mlflow

-Kubeflow	End-to-End ML Pipelines	Follow Kubeflow Docs

---
🎮 Fun & Experimental
Application	Use Case	Install Method

-Minecraft Server	Self-hosted Game Server	helm install mc itzg/minecraft

-WordPress	Self-hosted Blog/CMS	helm install wordpress bitnami/wordpress

-Ghost	Modern Blogging Platform	helm install ghost ghost/ghost

---
🚀 How to Choose?
For Learning DevOps:

Start with Argo CD + Prometheus + Grafana.

For Self-Hosting:

Try Nextcloud + Bitwarden + Jellyfin.

For AI/ML:

Deploy JupyterHub + MLflow.

📌 Pro Tips
Use Persistent Volumes (PVs) for databases (e.g., PostgreSQL for Gitea).

Secure with NetworkPolicies and RBAC.

Automate deployments with GitOps (Argo CD).

Want a detailed guide for any of these? Let me know which one! 🎯

