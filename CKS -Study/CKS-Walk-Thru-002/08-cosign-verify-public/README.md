[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)
[![Platform](https://img.shields.io/badge/platform-Ubuntu%2022.04%2B-lightgrey)](#)
[![Kubernetes](https://img.shields.io/badge/Kubernetes-MicroK8s%20%7C%20kubeadm-blue)](#)
[![YouTube](https://img.shields.io/badge/YouTube-TechShorts-red)](https://www.youtube.com/@adaribain)
[![LinkedIn](https://img.shields.io/badge/LinkedIn-Adari%20Bain-blue)](https://www.linkedin.com/in/adari-bain-298924152/)

✅ Revised Scenario 9: Cosign Verification (without Signing Your Own)
Instead of signing your own image (which requires Docker Hub auth + push), we’ll use a public image that’s already signed by its publisher. That way, you can focus on Kyverno + verifyImages, without fighting Podman + registry permissions.

📘 Real-World Context
Many official images (like distroless, ghcr.io/sigstore/cosign, etc.) are already signed with Cosign and verifiable with public keys.

🎯 Objectives
Install Cosign (CLI)

Install Kyverno (if not installed)

Use Cosign to verify an existing signed image

Create a verifyImages policy in Kyverno using a public key

Try deploying:

✅ Signed image → passes

❌ Unsigned image → fails

🧩 Image to Use: ghcr.io/sigstore/cosign
This is a small, signed image by the creators of Cosign.

📁 Files
bash
Copy
Edit
cks-labs/
└── 08-cosign-verify-public/
    ├── install-kyverno.sh
    ├── install-cosign.sh
    ├── verify-cosign-image.sh
    ├── kyverno-verify-policy.yaml
    ├── signed-pod.yaml
    ├── unsigned-pod.yaml
    ├── cleanup.sh
    └── README.md

    ---

🧪 Test
bash
Copy
Edit
kubectl apply -f kyverno-verify-policy.yaml
kubectl apply -f signed-pod.yaml     # ✅ allowed
kubectl apply -f unsigned-pod.yaml   # ❌ blocked

    ---

    🧠 Summary (README Excerpt)
markdown
Copy
Edit
# 🔐 Scenario 9 – Cosign + Kyverno with Publicly Signed Image

## ✅ Goal
Validate signed container images using Kyverno and public Cosign keys.

## 💡 Key Concepts
- Use images already signed by trusted orgs (e.g. Sigstore)
- Avoids complex login + push
- Kyverno’s `verifyImages` can use remote public keys

## 🧪 Test
```bash
cosign verify --key https://Fulcio.sigstore.dev/ghcr.pub ghcr.io/sigstore/cosign
kubectl apply -f signed-pod.yaml   # ✅
kubectl apply -f unsigned-pod.yaml # ❌
