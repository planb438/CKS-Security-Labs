[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)
[![Platform](https://img.shields.io/badge/platform-Ubuntu%2022.04%2B-lightgrey)](#)
[![Kubernetes](https://img.shields.io/badge/Kubernetes-MicroK8s%20%7C%20kubeadm-blue)](#)
[![YouTube](https://img.shields.io/badge/YouTube-TechShorts-red)](https://www.youtube.com/@adaribain)
[![LinkedIn](https://img.shields.io/badge/LinkedIn-Adari%20Bain-blue)](https://www.linkedin.com/in/adari-bain-298924152/)


--

sudo kubeadm reset --force

--

sudo rm -rf /var/lib/etcd /var/lib/kube* /etc/kubernetes /var/lib/rancher /var/lib/longhorn /var/lib/cni /etc/cni/net.d/*

--

sudo kubeadm init --pod-network-cidr=10.244.0.0/16

--

mkdir -p $HOME/.kube

--

sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config

--

sudo chown $(id -u):$(id -g) $HOME/.kube/config

--

kubectl apply -f https://raw.githubusercontent.com/projectcalico/calico/v3.26.1/manifests/calico.yaml

--

watch kubectl get pods -n kube-system -l k8s-app=calico-node

--

sudo systemctl restart kubelet

--

sudo shutdown reboot

--

kubectl get pods -n kube-system | grep -E 'flannel|calico|weave'

--

kubectl get pods -n kube-system

--

kubectl get nodes

--

## delete dns pod if needed #

--

kubectl delete pods -n kube-system -l k8s-app=kube-dns




















