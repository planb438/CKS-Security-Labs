[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)
[![Platform](https://img.shields.io/badge/platform-Ubuntu%2022.04%2B-lightgrey)](#)
[![Kubernetes](https://img.shields.io/badge/Kubernetes-MicroK8s%20%7C%20kubeadm-blue)](#)
[![YouTube](https://img.shields.io/badge/YouTube-TechShorts-red)](https://www.youtube.com/@adaribain)
[![LinkedIn](https://img.shields.io/badge/LinkedIn-Adari%20Bain-blue)](https://www.linkedin.com/in/adari-bain-298924152/)

### apparmor

Before you begin
AppArmor is an optional kernel module and Kubernetes feature, so verify it is supported on your Nodes before proceeding:
1. AppArmor kernel module is enabled -- For the Linux kernel to enforce an AppArmor profile, the AppArmor kernel module must be installed and enabled. Several distributions enable the module by default, such as Ubuntu and SUSE, and many others provide optional support. To check whether the module is enabled, check the /sys/module/apparmor/parameters/enabled file:
cat /sys/module/apparmor/parameters/enabled



1. The kubelet verifies that AppArmor is enabled on the host before admitting a pod with AppArmor explicitly configured.

2. Container runtime supports AppArmor -- All common Kubernetes-supported container runtimes should support AppArmor, including containerd and CRI-O. Please refer to the corresponding runtime documentation and verify that the cluster fulfills the requirements to use AppArmor.

3. Profile is loaded -- AppArmor is applied to a Pod by specifying an AppArmor profile that each container should be run with. If any of the specified profiles are not loaded in the kernel, the kubelet will reject the Pod. You can view which profiles are loaded on a node by checking the /sys/kernel/security/apparmor/profiles file. For example:
sudo cat /sys/kernel/security/apparmor/profiles | sort


Usage: aa-status [OPTIONS]
Displays various information about the currently loaded AppArmor policy.
Default if no options given
  --show=all

aa-status

