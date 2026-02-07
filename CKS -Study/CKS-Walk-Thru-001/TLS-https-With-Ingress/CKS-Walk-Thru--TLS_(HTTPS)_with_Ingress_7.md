## TLS (HTTPS) with Ingress
wesome — let’s move on to TLS with Ingress. This is a high-priority CKS topic, as it touches on encryption, cert management, and secure exposure of apps to the outside world.

✅ TLS (HTTPS) with Ingress

🔍 Purpose
Ingress with TLS ensures your app is securely accessible via HTTPS, protecting data in transit and aligning with zero-trust principles.

🛠 Step-by-Step Setup (Self-Signed TLS Cert)

1. Generate a Self-Signed TLS Certificate



openssl req -x509 -nodes -days 365 \
  -newkey rsa:2048 \
  -out tls.crt \
  -keyout tls.key \
  -subj "/CN=yourapp.local/O=YourOrg"


This creates:
• tls.crt: public certificate

• tls.key: private key



2. Create a TLS Secret in Kubernetes
bash
CopyEdit


kubectl create secret tls node-app-tls \
  --cert=tls.crt \
  --key=tls.key \
  -n dev


Verify:


kubectl get secret node-app-tls -n dev



3. Install an Ingress Controller (NGINX)
If you haven’t installed one:



helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
helm install ingress-nginx ingress-nginx/ingress-nginx \
  --namespace ingress-nginx --create-namespace


Check the external IP:



kubectl get svc -n ingress-nginx



4. Create Ingress Resource with TLS
yaml



apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: node-app-ingress
  namespace: dev
  annotations:
    nginx.ingress.kubernetes.io/rewrite-target: /
spec:
  tls:
  - hosts:
      - yourapp.local
    secretName: node-app-tls
  rules:
  - host: yourapp.local
    http:
      paths:
      - path: /
        pathType: Prefix
        backend:
          service:
            name: node-app-service
            port:
              number: 3000


Deploy:



kubectl apply -f node-app-ingress.yaml



5. Update /etc/hosts for Local DNS Resolution



echo "127.0.0.1 yourapp.local" | sudo tee -a /etc/hosts



🔐 Security Best Practices

| Practice | Why It Matters |
| Always use tls: in Ingress | Avoid plaintext HTTP endpoints |
| Use cert-manager in production | Automates Let's Encrypt certs |
| Restrict ingress access via network policies | Prevent unwanted external exposure |
| Rotate self-signed certs periodically | Even for dev/test environments |




🧪 Test



curl -k https://yourapp.local


(Use -k to skip cert validation since it's self-signed)

✅ What You Should Remember
◇ TLS with Ingress = encrypted app access.

◇ Use Ingress + Secret + Ingress Controller in tandem.

◇ Move to cert-manager + Let’s Encrypt for automation later.


Ready to roll into Prometheus & Grafana observability next?





Thanks for the heads-up — you're absolutely right, and this is a common hurdle in home labs.
The issue you're seeing:
curl: (7) Failed to connect to yourapp.local port 443
…combined with external IP stuck in <pending>, tells us that your NGINX Ingress Controller is using a LoadBalancer Service, which doesn’t work out-of-the-box on VirtualBox/Vagrant setups (no cloud provider = no cloud load balancer).

✅ Fix: Expose Ingress Controller via NodePort (Home Lab Compatible)

🔧 Step-by-Step:
1. Patch the ingress controller service to use NodePort


kubectl patch svc ingress-nginx-controller \
  -n ingress-nginx \
  -p '{"spec": {"type": "NodePort"}}'


1. Find the new NodePort



kubectl get svc ingress-nginx-controller -n ingress-nginx


You'll see something like:


ingress-nginx-controller   NodePort   10.0.0.42   <none>   80:31123/TCP,443:32714/TCP


In this case:
• HTTP = 31123

• HTTPS = 32714


1. Edit /etc/hosts to point your domain to a worker node IP




echo "192.168.56.11 yourapp.local" | sudo tee -a /etc/hosts


(Replace 192.168.56.11 with your worker node IP, or control plane IP if the ingress controller runs there.)
1. Try curling again using NodePort




curl -k https://yourapp.local:32714



✅ Optional: Port Forward (Quick & Dirty)
You can also test temporarily via port-forwarding:



kubectl port-forward svc/ingress-nginx-controller 8443:443 -n ingress-nginx


Then:



curl -k https://localhost:8443



✅ Summary Fix Checklist

| Item | Check |
| Ingress controller is NodePort | ✅ |
| /etc/hosts updated to point to a real node | ✅ |
| Used correct port from kubectl get svc | ✅ |
| curl -k https://yourapp.local:<NodePort> | ✅ |



Once that works, you're good to go and we can proceed with Prometheus & Grafana. Want to move forward?

























