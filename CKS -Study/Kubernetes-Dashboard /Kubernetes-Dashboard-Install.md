Below is a step-by-step guide to installing the Kubernetes Dashboard using Helm in your home lab, along with documentation for GitHub.

📌 Step 1: Prerequisites
✅ A running Kubernetes cluster (e.g., k3s, minikube, or kubeadm).
✅ Helm installed (helm CLI).
✅ kubectl configured (kubectl get nodes should work).

🚀 Step 2: Install Kubernetes Dashboard via Helm
1. Add the Helm Repository
bash
helm repo add kubernetes-dashboard https://kubernetes.github.io/dashboard/
helm repo update
2. Install the Dashboard
bash
helm upgrade --install kubernetes-dashboard kubernetes-dashboard/kubernetes-dashboard \
  --namespace kubernetes-dashboard \
  --create-namespace \
  --set protocolHttp=true \
  --set service.type=NodePort \
  --set service.nodePort=30080
Flags Explained:

--namespace kubernetes-dashboard: Creates a dedicated namespace.

--set protocolHttp=true: Forces HTTP (for simplicity in a lab).

--set service.type=NodePort: Exposes the dashboard on a fixed port.

--set service.nodePort=30080: Uses port 30080 for access.

🔐 Step 3: Access the Dashboard
1. Get the NodePort URL
bash
kubectl get svc -n kubernetes-dashboard
Example output:

text
NAME                        TYPE       CLUSTER-IP      PORT(S)         AGE
kubernetes-dashboard        NodePort   10.43.123.45   443:30080/TCP   2m
👉 Access it at:

Local machine: http://<NODE_IP>:30080

If using minikube:

bash
minikube service kubernetes-dashboard -n kubernetes-dashboard --url
2. Create an Admin User (for Login)
bash
cat <<EOF | kubectl apply -f -
apiVersion: v1
kind: ServiceAccount
metadata:
  name: admin-user
  namespace: kubernetes-dashboard
---
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRoleBinding
metadata:
  name: admin-user
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: ClusterRole
  name: cluster-admin
subjects:
- kind: ServiceAccount
  name: admin-user
  namespace: kubernetes-dashboard
EOF
3. Get the Login Token
  
---

bash
kubectl -n kubernetes-dashboard create token admin-user
📌 Copy the token and paste it into the Dashboard login page.

📂 Step 4: Documenting on GitHub
1. Create a README.md
markdown
# Kubernetes Dashboard Setup with Helm

## 🚀 Installation
```bash
helm repo add kubernetes-dashboard https://kubernetes.github.io/dashboard/
helm upgrade --install kubernetes-dashboard kubernetes-dashboard/kubernetes-dashboard \
  --namespace kubernetes-dashboard \
  --create-namespace \
  --set protocolHttp=true \
  --set service.type=NodePort \
  --set service.nodePort=30080
🔐 Access
Open: http://<NODE_IP>:30080

Get the token:

bash
kubectl -n kubernetes-dashboard create token admin-user
📜 Troubleshooting
"Forbidden" error? Ensure RBAC is correctly applied.

Dashboard not loading? Check kubectl get pods -n kubernetes-dashboard.

text

### **2. Push to GitHub**
```bash
git init
git add README.md
git commit -m "Added Kubernetes Dashboard setup guide"
git branch -M main
git remote add origin https://github.com/yourusername/kubernetes-dashboard-setup.git
git push -u origin main
⚡ Step 5: Optional Enhancements
1. Secure with HTTPS (Cert-Manager)
bash
helm install cert-manager jetstack/cert-manager --set installCRDs=true
Then modify the Helm install to use HTTPS.

2. Ingress Setup (Traefik/Nginx)
yaml
# Example Ingress (if using Traefik)
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: dashboard-ingress
  namespace: kubernetes-dashboard
  annotations:
    traefik.ingress.kubernetes.io/router.entrypoints: websecure
spec:
  rules:
  - host: dashboard.yourdomain.com
    http:
      paths:
      - path: /
        pathType: Prefix
        backend:
          service:
            name: kubernetes-dashboard
            port:
              number: 443


---

It looks like your Kubernetes Dashboard services are all set to ClusterIP, which means they're not directly accessible from outside the cluster. Let's patch the kubernetes-dashboard-kong-proxy service to use NodePort so you can access it easily in your home lab.

Step 1: Patch the Kong Proxy Service to Use NodePort
bash
kubectl patch svc kubernetes-dashboard-kong-proxy -n kubernetes-dashboard -p '{"spec": {"type": "NodePort"}}'
Step 2: Verify the Change
bash
kubectl get svc -n kubernetes-dashboard
Now, you should see kubernetes-dashboard-kong-proxy listed as NodePort with a high port number (e.g., 3xxxx).


