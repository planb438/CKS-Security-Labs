kubectl delete ns audit-test
sudo mv /etc/kubernetes/manifests/kube-apiserver.yaml.bak /etc/kubernetes/manifests/kube-apiserver.yaml
sudo systemctl restart kubelet
