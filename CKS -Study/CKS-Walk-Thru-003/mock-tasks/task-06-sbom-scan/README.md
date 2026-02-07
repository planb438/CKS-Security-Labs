[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)
[![Platform](https://img.shields.io/badge/platform-Ubuntu%2022.04%2B-lightgrey)](#)
[![Kubernetes](https://img.shields.io/badge/Kubernetes-MicroK8s%20%7C%20kubeadm-blue)](#)
[![YouTube](https://img.shields.io/badge/YouTube-TechShorts-red)](https://www.youtube.com/@adaribain)
[![LinkedIn](https://img.shields.io/badge/LinkedIn-Adari%20Bain-blue)](https://www.linkedin.com/in/adari-bain-298924152/)

🧰 Task 14.6 – SBOM & Image Vulnerability Scanning with Syft + Grype
📘 Scenario
You need to:

Build a sample container image

Generate an SBOM (Software Bill of Materials) using Syft

Scan for vulnerabilities using Grype

Identify if any CRITICAL or HIGH CVEs exist

🎯 Objectives
Install syft and grype if not already installed

Build a small demo image using podman

Generate SBOM (JSON or table)

Run a vulnerability scan

Filter for high/critical CVEs

📁 File Structure
bash
Copy
Edit
cks-labs/
└── 14-mock-tasks/
    └── task-06-sbom-scan/
        ├── 00-install-tools.sh
        ├── 01-Dockerfile
        ├── 02-build-image.sh
        ├── 03-generate-sbom.sh
        ├── 04-scan-image.sh
        ├── cleanup.sh
        └── README.md

---

📘 README.md Summary
markdown
Copy
Edit
# 🧰 Task 6 – SBOM + Image Vulnerability Scan

## 🎯 Goal
Generate a Software Bill of Materials and detect CVEs using open source tools.

## 🛠 Tools
- `syft` – creates SBOM (SPDX, CycloneDX, JSON)
- `grype` – scans for known CVEs

## 🚀 Deployment
```bash
./00-install-tools.sh
./02-build-image.sh
./03-generate-sbom.sh
./04-scan-image.sh
✅ Expect Grype to show Python or OS package vulnerabilities.

💡 CKS Tip
Combine Syft SBOMs with Kyverno or CI pipelines

Scanning local images is fair game in CKS exam

Look for HIGH and CRITICAL only under time pressure

yaml
Copy
Edit
