[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)
[![Platform](https://img.shields.io/badge/platform-Ubuntu%2022.04%2B-lightgrey)](#)
[![Kubernetes](https://img.shields.io/badge/Kubernetes-MicroK8s%20%7C%20kubeadm-blue)](#)
[![YouTube](https://img.shields.io/badge/YouTube-TechShorts-red)](https://www.youtube.com/@adaribain)
[![LinkedIn](https://img.shields.io/badge/LinkedIn-Adari%20Bain-blue)](https://www.linkedin.com/in/adari-bain-298924152/)

--

Backing up an etcd cluster 

--

export ETCDCTL_API=3

---

sudo etcdctl --endpoints=https://127.0.0.1:2379 \
  --cacert=/etc/kubernetes/pki/etcd/ca.crt --cert=/etc/kubernetes/pki/etcd/server.crt --key=/etc/kubernetes/pki/etcd/server.key \
  snapshot save /home/master-node-001/backUp-Cluster-kubernetes.db

---

  sudo etcdctl --write-out=table snapshot status backUp-Cluster-kubernetes.db

  ---
  
export ETCDCTL_API=3

---

etcdctl --data-dir <data-dir-location> snapshot restore snapshot.db

---

Here's how to properly restore your etcd snapshot:

--

Solution: Force Restore Etcd Snapshot
First, stop kube-apiserver (to prevent conflicts):

--

bash
sudo systemctl stop kube-apiserver
Remove the existing etcd data directory:

bash
sudo rm -rf /var/lib/etcd/default.etcd
Restore the snapshot (using your original command with --data-dir flag):

bash
sudo ETCDCTL_API=3 etcdctl --endpoints=https://127.0.0.1:2379 \
  --cacert=/etc/kubernetes/pki/etcd/ca.crt \
  --cert=/etc/kubernetes/pki/etcd/server.crt \
  --key=/etc/kubernetes/pki/etcd/server.key \
  snapshot restore /home/master-node-001/backUp-Cluster-kubernetes.db \
  --data-dir=/var/lib/etcd/restored
Update etcd service configuration (if you restored to a non-default path):

bash
sudo vim /etc/kubernetes/manifests/etcd.yaml
Change the --data-dir flag to point to your restored directory:

yaml
- --data-dir=/var/lib/etcd/restored
Restart etcd and kube-apiserver:

bash
sudo systemctl restart kubelet
sudo systemctl start kube-apiserver
Verify the restore:

bash
sudo ETCDCTL_API=3 etcdctl --endpoints=https://127.0.0.1:2379 \
  --cacert=/etc/kubernetes/pki/etcd/ca.crt \
  --cert=/etc/kubernetes/pki/etcd/server.crt \
  --key=/etc/kubernetes/pki/etcd/server.key \
  get / --prefix --keys-only
Alternative Method (If Using kubeadm)
If you're using kubeadm, you can also restore the etcd snapshot like this:

bash
sudo kubeadm etcd snapshot restore /home/master-node-001/backUp-Cluster-kubernetes.db \
  --data-dir=/var/lib/etcd/restored
Key Notes
Cluster Downtime: This process requires temporary downtime of the control plane.

Backup First: Always backup current etcd data before restoring.

Consistency: Ensure all control plane nodes are restored to the same snapshot if you have a multi-master setup.

sudo reboot

---

If you run sudo kubeadm reset --force followed by a restore from an etcd snapshot backup, here's exactly what will be included (and excluded) from your restored cluster state:

--

What's Included in the Restore ✅

--

All Kubernetes Objects:

Pods, Deployments, Services, ConfigMaps, Secrets, etc.

PersistentVolumeClaims (PVCs) and StorageClass definitions

Namespaces and RBAC permissions

CRDs and custom resources

Cluster State:

Exact state of all objects at the time of the etcd snapshot

Node registration records (but see caveats below)

Kubernetes Internal Configs:

Cluster API versions and extensions

Scheduler/controller-manager states

What's NOT Included ❌

--

Node Components:

Kubelet configurations on worker nodes

Container Runtime (Docker/containerd) state

Actual container filesystems (only metadata is stored in etcd)

Persistent Volume Data:

Contents of your PVs (unless you separately backed up storage)

Example: If you used local-path, the actual data lives on node disks

Network Configs:

CNI plugin configurations (Calico/Flannel/etc.)

iptables rules or network policies

Addons:

Helm releases (unless stored as Kubernetes objects)

Ingress controller deployments

Step-by-Step Recovery Process
Reset the Cluster (on all control plane nodes):

bash
sudo kubeadm reset --force
sudo rm -rf /etc/kubernetes/pki
Restore etcd Snapshot (on first control plane node):

bash
sudo kubeadm init phase etcd snapshot --snapshot-file=backup.db
Reinitialize Control Plane:

bash
sudo kubeadm init --ignore-preflight-errors=DirAvailable--var-lib-etcd
Rejoin Worker Nodes:

bash
kubeadm token create --print-join-command
# Run output on worker nodes
Restore Network Plugin:

bash
kubectl apply -f https://docs.projectcalico.org/manifests/calico.yaml
Critical Post-Restore Actions
Verify Persistent Volume Claims:

bash
kubectl get pvc --all-namespaces -o wide
Check Node Status:

bash
kubectl get nodes
# If nodes show "NotReady", restart kubelet:
sudo systemctl restart kubelet
Restore Addons:

Reinstall CoreDNS, metrics-server, etc.:

bash
kubectl apply -f https://github.com/kubernetes-sigs/metrics-server/releases/latest/download/components.yaml
Pro Tip: Full Cluster Recovery Checklist
For a comprehensive restore, you should have:

Etcd snapshot (cluster state)

PV data backup (e.g., Velero/Restic)

CNI config backups

Kubeadm config files (/etc/kubernetes/admin.conf)

