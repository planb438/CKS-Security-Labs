---
wget https://cm.lf.training/LFS258/LFS258_V2025-03-06_SOLUTIONS.tar.xz --user=LFtraining --password=Penguin2014

tar -xvf LFS258V2025-03-06SOLUTIONS.tar.xz

apt-get update && apt-get upgrade -y

apt install apt-transport-https \
software-properties-common ca-certificates socat -y

swapoff -a

---

modprobe overlay
modprobe br_netfilter


cat << EOF | tee /etc/sysctl.d/kubernetes.conf
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
net.ipv4.ip_forward = 1
EOF


sysctl --system

---

mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg \
| sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg


echo \
"deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] \
https://download.docker.com/linux/ubuntu \
$(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

---

apt-get update &&  apt-get install containerd.io -y
containerd config default | tee /etc/containerd/config.toml
sed -e' s/SystemdCgroup = false/SystemdCgroup = true/g' -i /etc/containerd/config.toml
systemctl restart containerd



curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.31/deb/Release.key \
| sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg



echo "deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] \
https://pkgs.k8s.io/core:/stable:/v1.31/deb/ /" \
| sudo tee /etc/apt/sources.list.d/kubernetes.list

---


apt-get update


apt-get install -y kubeadm=1.31.1-1.1 kubelet=1.31.1-1.1 kubectl=1.31.1-1.1

apt-mark hold kubelet kubeadm kubectl


---

# Add an local DNS alias for our cp server.  Edit the/etc/hostsfile and add the above IP address and assign a namek8scp.
# root@cp: ̃# vim /etc/hosts10.128.0.3 k8scp    #<-- Add this line10.128.0.3 cp       #<-- Add this line127.0.0.1 localhost





cp /home/student/LFS258/SOLUTIONS/s_03/kubeadm-config.yaml /root/


kubeadm init --config=kubeadm-config.yaml --upload-certs --node-name=cp \
| tee kubeadm-init.out                 #<-- Save output for future review



exit


mkdir -p $HOME/.kubesudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config
less .kube/confi 

---

find $HOME -name cilium-cni.yaml
kubectl apply -f /home/student/LFS258/SOLUTIONS/s_03/cilium-cni.yaml

