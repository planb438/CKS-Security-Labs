#!/bin/bash
# Install kubeadm on master - that's it
apt-get update
apt-get install -y apt-transport-https ca-certificates curl
swapoff -a
sed -i '/swap/d' /etc/fstab
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" > /etc/apt/sources.list.d/docker.list
apt-get update
apt-get install -y containerd.io
mkdir -p /etc/containerd
containerd config default > /etc/containerd/config.toml
sed -i 's/SystemdCgroup = false/SystemdCgroup = true/' /etc/containerd/config.toml
systemctl restart containerd
curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.31/deb/Release.key | gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg
echo "deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.31/deb/ /" > /etc/apt/sources.list.d/kubernetes.list
apt-get update
apt-get install -y kubeadm=1.31.1-1.1 kubelet=1.31.1-1.1 kubectl=1.31.1-1.1
apt-mark hold kubelet kubeadm kubectl
cat << EOF | sudo tee /etc/sysctl.d/kubernetes.conf
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
net.ipv4.ip_forward = 1
EOF
sudo sysctl --system
echo "Master ready for kubeadm init"


---

# Add an local DNS alias for our cp server.  Edit the/etc/hostsfile and add the above IP address and assign a namek8scp.
# root@cp: ̃# vim /etc/hosts10.128.0.3 k8scp    #<-- Add this line10.128.0.3 cp       #<-- Add this line127.0.0.1 localhost





kubeadm init --pod-network-cidr=10.0.0.0/16 --node-name=cp | tee kubeadm-init.out                 #<-- Save output for future review



exit


mkdir -p $HOME/.kube 
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config
less .kube/config

---

Step-by-Step Installation with Cilium CLI
The following steps use the Cilium CLI for a streamlined installation:
Install the Cilium CLI
Download and extract the latest Cilium CLI to your local machine (e.g., /usr/local/bin):
bash
curl -LO https://github.com/cilium/cilium-cli/releases/latest/download/cilium-linux-amd64.tar.gz
sudo tar xzvfC cilium-linux-amd64.tar.gz /usr/local/bin
rm cilium-linux-amd64.tar.gz
(Adjust for your operating system and architecture if necessary).
Set KUBECONFIG Environment Variable
If you're running the command from a machine other than the control plane node, ensure your KUBECONFIG environment variable is set correctly to point to your cluster's configuration file (e.g., export KUBECONFIG=$HOME/.kube/config).
Deploy Cilium
Run the cilium install command. The CLI will automatically detect the cluster configuration and install the necessary components.
bash
cilium install
Note on Pod CIDR: If your cluster uses a specific Pod CIDR range (e.g., 10.10.0.0/16) that the CLI might not auto-detect, you may need to specify it to avoid IP conflicts:
bash
cilium install --set ipam.operator.clusterPoolIPv4PodCIDRList=10.10.0.0/16
.
Validate the Installation
Check the status of the Cilium deployment using the cilium status command:
bash
cilium status
This command provides an overview and confirms all components are running correctly. You can also check the pods in the kube-system namespace:
bash
kubectl get pods --namespace=kube-system -l k8s-app=cilium
.
Run Connectivity Tests (Optional but Recommended)
Deploy the built-in connectivity test to verify that pod-to-pod communication is working as expected:
bash
cilium connectivity test
