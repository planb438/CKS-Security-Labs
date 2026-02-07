[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)
[![Platform](https://img.shields.io/badge/platform-Ubuntu%2022.04%2B-lightgrey)](#)
[![Kubernetes](https://img.shields.io/badge/Kubernetes-MicroK8s%20%7C%20kubeadm-blue)](#)
[![YouTube](https://img.shields.io/badge/YouTube-TechShorts-red)](https://www.youtube.com/@adaribain)
[![LinkedIn](https://img.shields.io/badge/LinkedIn-Adari%20Bain-blue)](https://www.linkedin.com/in/adari-bain-298924152/)

🧰 Scenario 12: SBOM & Vulnerability Scanning with Syft + Grype
📘 Real-World Context
Modern DevSecOps workflows require knowing what’s inside your container images. You can generate an SBOM (Software Bill of Materials) and scan it for known CVEs using:

Syft: generates SBOMs (JSON, SPDX, CycloneDX)

Grype: scans SBOMs or images for vulnerabilities

🎯 Objectives
Install Syft & Grype locally

Pull or build a test image

Generate an SBOM using Syft

Scan the image (or SBOM) with Grype

Interpret output and map to CKS use cases

📁 Structure
bash
Copy
Edit
cks-labs/
└── 12-sbom-vuln-scan/
    ├── 00-install-syft-grype.sh
    ├── 01-sbom-generate.sh
    ├── 02-grype-scan.sh
    ├── 03-demo-image.Dockerfile
    ├── README.md



---

🐳 03-demo-image.Dockerfile
Dockerfile
Copy
Edit
FROM python:3.8-slim
RUN pip install flask
Build with:

bash
Copy
Edit
podman build -t local/sbom-demo:1.0 -f 03-demo-image.Dockerfile

---

📘 README.md Summary
markdown
Copy
Edit
# 🧰 Scenario 12 – SBOM + Vulnerability Scanning

## 🎯 Goal
Generate a Software Bill of Materials (SBOM) and scan for known vulnerabilities.

## 🛠 Tools
- **Syft** = generate SBOM
- **Grype** = scan image or SBOM

## 🧪 Test Flow
```bash
./00-install-syft-grype.sh
podman build -t local/sbom-demo:1.0 -f 03-demo-image.Dockerfile
./01-sbom-generate.sh
./02-grype-scan.sh
✅ CKS Tips
SBOM generation is increasingly required in compliance-focused orgs

Combine Grype output with CI/CD admission rules (e.g. deny HIGH severity)

SBOMs can be exported as SPDX or CycloneDX and attached to image metadata


---


⠇ Pulling image                   
[0003] ERROR could not determine source: errors occurred attempting to resolve 'local/sbom-demo:1.0':


You're seeing:

vbnet
Copy
Edit
ERROR could not determine source: errors occurred attempting to resolve 'local/sbom-demo:1.0'
This usually happens when syft or grype can't find the image locally due to:

🔍 Common Causes
1. The image wasn’t built or tagged correctly
You may not have actually built local/sbom-demo:1.0 yet

Or you built it using Podman but didn’t allow it to be seen by Docker-compatible tooling

✅ Fix: Build and Tag the Image in Podman First
Run this exactly before you run syft or grype:

bash
Copy
Edit
podman build -t sbom-demo:1.0 -f 03-demo-image.Dockerfile
Use sbom-demo:1.0 without the local/ prefix. Podman stores images differently than Docker, and tools like syft/grype don’t resolve the local/ namespace unless explicitly configured.

✅ Then Run Syft and Grype:
bash
Copy
Edit
syft sbom-demo:1.0 -o json > sbom.json
grype sbom-demo:1.0
🧠 Optional: If You Use Docker Instead of Podman
If you prefer to switch to Docker temporarily for compatibility with Anchore tools:

bash
Copy
Edit
docker build -t sbom-demo:1.0 -f 03-demo-image.Dockerfile
syft sbom-demo:1.0
grype sbom-demo:1.0
But it will also work with Podman as long as:

The image is built in your user scope

You avoid local/ in the tag unless you’ve configured /etc/containers/registries.conf accordingly
