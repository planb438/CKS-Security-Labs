#!/bin/bash
# Make sure /var/log/kubernetes/ exists or is writable.
if [ ! -d /var/log/kubernetes ]; then
    echo "[!] /var/log/kubernetes/ does not exist. Creating it."
    sudo mkdir -p /var/log/kubernetes
fi
if [ ! -w /var/log/kubernetes ]; then
    echo "[!] /var/log/kubernetes/ is not writable. Changing permissions."
    sudo chmod 777 /var/log/kubernetes
fi

echo "[+] Placing audit policy at /etc/kubernetes/"
sudo cp audit-policy.yaml /etc/kubernetes/

echo "[+] Backing up kube-apiserver manifest"
sudo cp /etc/kubernetes/manifests/kube-apiserver.yaml /etc/kubernetes/manifests/kube-apiserver.yaml.bak

echo "[+] Patching kube-apiserver manifest...Skipping for now.... Do manually - Look at the file /etc/kubernetes/manifests/kube-apiserver.yaml and add the following lines to the spec.containers.args section:"
echo "    - --audit-log-maxage=30"
echo "    - --audit-log-maxbackup=10"
echo "    - --audit-log-maxsize=100"
echo "    - --audit-log-path=/var/log/kubernetes/audit.log"
echo "    - --audit-policy-file=/etc/kubernetes/audit-policy.yaml"
echo "    - --audit-log-format=json"
echo "[+] kube-apiserver will restart via static pod automatically"
