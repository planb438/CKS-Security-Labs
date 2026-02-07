[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)
[![Platform](https://img.shields.io/badge/platform-Ubuntu%2022.04%2B-lightgrey)](#)
[![Kubernetes](https://img.shields.io/badge/Kubernetes-MicroK8s%20%7C%20kubeadm-blue)](#)
[![YouTube](https://img.shields.io/badge/YouTube-TechShorts-red)](https://www.youtube.com/@adaribain)
[![LinkedIn](https://img.shields.io/badge/LinkedIn-Adari%20Bain-blue)](https://www.linkedin.com/in/adari-bain-298924152/)

### SBOM

---

Introduction to Software Bill of Materials (SBOM) and Its Importance in Software Supply Chain Security
A Software Bill of Materials (SBOM) is a comprehensive inventory of all components, libraries, and modules within a piece of software. It is crucial for ensuring software supply chain security by providing transparency and allowing organizations to identify and address vulnerabilities efficiently.
SBOMs enable:
• Better management of software dependencies,
• Improved compliance with licensing requirements,
• Quick responses to security threats.

By adopting SBOMs, organizations can enhance their security posture and reduce risks associated with third-party software components.

---

Download the Syft tool and move the binary to /usr/local/bin.

curl -sSfL https://raw.githubusercontent.com/anchore/syft/main/install.sh | sh -s -- -b /usr/local/bin

syft --help

---

Grype A vulnerability scanner for container images, filesystems, and SBOMs
Download the Grype tool and move the binary to /usr/local/bin.

curl -sSfL https://raw.githubusercontent.com/anchore/grype/main/install.sh | sh -s -- -b /usr/local/bin

grype --help


You can also pipe in Syft JSON directly:
 syft yourimage:tag -o json | grype
 
 
 ---
 
 
Automating SBOM Generation in CI/CD
Learning Outcomes:
By the end of this lab, participants will be able to:
• Understand the importance of automating SBOM generation in CI/CD pipelines.
• Set up a GitHub Actions workflow for SBOM generation.
• Use Syft to generate SBOMs in a CI/CD environment.
• Configure artifact uploading in GitHub Actions.
• Interpret and utilize the generated SBOM in a CI/CD context.

---

Follow the instructions below to configure your GitHub credential before going to the next questions.

Open the lab console and configure following environment variables with your own GitHub account information:
vi /root/github_repo_info.json
{
    "REPO_OWNER": "your_username_here",
    "ACCESS_TOKEN": "your_access_token_here"
}The provided information will solely be utilized for validating your response in the next question. Please note, we do not retain this information for any other purposes.


Refer to this document if you're not sure how to get your own access token: Managing your personal access tokens

---

Fork the Repository - https://github.com/iampsrv/supply_chain_security to use as a starting point.
• Note that the Repository name is supply_chain_security (do not change it).
• Go through the repository. It contains nginx-sbom.json, nginx-spdx.sbom and a .github/workflows directory.
• Explore the main.yml file.
• Enable GitHub Actions



