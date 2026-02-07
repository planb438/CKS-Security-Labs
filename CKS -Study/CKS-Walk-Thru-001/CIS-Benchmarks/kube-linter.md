[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)
[![Platform](https://img.shields.io/badge/platform-Ubuntu%2022.04%2B-lightgrey)](#)
[![Kubernetes](https://img.shields.io/badge/Kubernetes-MicroK8s%20%7C%20kubeadm-blue)](#)
[![YouTube](https://img.shields.io/badge/YouTube-TechShorts-red)](https://www.youtube.com/@adaribain)
[![LinkedIn](https://img.shields.io/badge/LinkedIn-Adari%20Bain-blue)](https://www.linkedin.com/in/adari-bain-298924152/)

### kube-linter
KubeLinter is a static analysis tool that checks Kubernetes YAML files and Helm charts to ensure the applications represented in them adhere to best practices.


Performing Static Analysis with KubeLinter
Learning Outcomes:
By the end of this lab, participants will be able to:
• Understand the importance of static analysis in Kubernetes manifest files.
• Install and set up KubeLinter on a Linux system.
• Use KubeLinter to analyze Kubernetes YAML files.
• Interpret KubeLinter results and identify common issues in Kubernetes manifests.
• Apply best practices to improve Kubernetes manifest files based on KubeLinter feedback.

curl -LO https://github.com/stackrox/kube-linter/releases/latest/download/kube-linter-linux.tar.gz
tar -xvf kube-linter-linux.tar.gz
mv kube-linter /usr/local/bin/



kube-linter -h
Usage:
  kube-linter [command]

Available Commands:
  checks      View more information on lint checks
  completion  Generate the autocompletion script for the specified shell
  help        Help about any command
  lint        Lint Kubernetes YAML files and Helm charts
  templates   View more information on check templates
  version     Print version and exit

Flags:
  -h, --help         help for kube-linter
      --with-color   Force color output (default true)

Use "kube-linter [command] --help" for more information about a command.

