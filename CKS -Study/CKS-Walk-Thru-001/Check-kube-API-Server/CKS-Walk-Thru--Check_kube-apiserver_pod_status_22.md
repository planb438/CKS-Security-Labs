[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)
[![Platform](https://img.shields.io/badge/platform-Ubuntu%2022.04%2B-lightgrey)](#)
[![Kubernetes](https://img.shields.io/badge/Kubernetes-MicroK8s%20%7C%20kubeadm-blue)](#)
[![YouTube](https://img.shields.io/badge/YouTube-TechShorts-red)](https://www.youtube.com/@adaribain)
[![LinkedIn](https://img.shields.io/badge/LinkedIn-Adari%20Bain-blue)](https://www.linkedin.com/in/adari-bain-298924152/)

## Check kube-apiserver pod status

Check kube-apiserver pod status
Since it’s a static pod, check its logs:
bash
CopyEdit


sudo crictl ps -a | grep kube-apiserver


Then check logs for the pod ID you see:



sudo crictl logs <CONTAINER_ID>


You’re likely to see a config parsing or key error.


