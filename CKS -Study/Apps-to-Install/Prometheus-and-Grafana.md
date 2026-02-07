[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)
[![Platform](https://img.shields.io/badge/platform-Ubuntu%2022.04%2B-lightgrey)](#)
[![Kubernetes](https://img.shields.io/badge/Kubernetes-MicroK8s%20%7C%20kubeadm-blue)](#)
[![YouTube](https://img.shields.io/badge/YouTube-TechShorts-red)](https://www.youtube.com/@adaribain)
[![LinkedIn](https://img.shields.io/badge/LinkedIn-Adari%20Bain-blue)](https://www.linkedin.com/in/adari-bain-298924152/)
 
 Starting with Prometheus + Grafana will give you comprehensive monitoring capabilities for your Kubernetes cluster. Here's a step-by-step guide to install and configure them using Helm in your home lab:

Step 1: Add Helm Repositories
Ensure you have the Prometheus Community Helm repo:

bash
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo update
Step 2: Install kube-prometheus-stack
This Helm chart bundles Prometheus, Grafana, Alertmanager, and essential Kubernetes monitoring tools (like Node Exporter and Kube-State-Metrics).

bash
helm install prometheus-stack prometheus-community/kube-prometheus-stack \
  --namespace monitoring \
  --create-namespace \
  --set prometheus.prometheusSpec.serviceMonitorSelectorNilUsesHelmValues=false \
  --set grafana.service.type=NodePort
Flags Explained:
--namespace monitoring: Creates a dedicated namespace.

serviceMonitorSelectorNilUsesHelmValues=false: Ensures Prometheus discovers all ServiceMonitors (not just Helm-managed ones).

grafana.service.type=NodePort: Exposes Grafana on a NodePort for easy access.

Step 3: Verify Installation
Check if pods are running:

bash
kubectl get pods -n monitoring
Expected output (look for Running status):

text
NAME                                                     READY   STATUS    RESTARTS   AGE
prometheus-stack-kube-prom-operator-xxxxx                1/1     Running   0          2m
prometheus-stack-grafana-xxxxx                           2/2     Running   0          2m
prometheus-stack-kube-state-metrics-xxxxx               1/1     Running   0          2m
prometheus-stack-prometheus-node-exporter-xxxxx         1/1     Running   0          2m
Step 4: Access Grafana
Get the NodePort:

bash
kubectl get svc -n monitoring prometheus-stack-grafana
Example output:

text
NAME                         TYPE       CLUSTER-IP     PORT(S)        AGE
prometheus-stack-grafana     NodePort   10.96.123.45  80:32345/TCP   5m
Here, Grafana is exposed on port 32345.

Access Grafana:

Open a browser and navigate to: http://<your-worker-node-ip>:32345

Default credentials:

Username: admin

Password: Get it with:

bash
kubectl get secret -n monitoring prometheus-stack-grafana -o jsonpath='{.data.admin-password}' | base64 --decode
Step 5: Access Prometheus
Prometheus is cluster-internal by default. To access it:

Port-forward:

bash
kubectl port-forward -n monitoring svc/prometheus-stack-kube-prom-prometheus 9090
Visit http://localhost:9090 in your browser.

Step 6: Import Dashboards in Grafana
Grafana auto-imports Kubernetes dashboards. To manually add more:

Go to Dashboards > Import.

Use dashboard IDs like:

Kubernetes Cluster: 6417

Nodes: 1860

Pods: 6418

Optional: Persistence
To retain metrics/data across reboots, add these flags during Helm install:

bash
--set prometheus.prometheusSpec.storageSpec.volumeClaimTemplate.spec.storageClassName=<your-storage-class> \
--set prometheus.prometheusSpec.storageSpec.volumeClaimTemplate.spec.resources.requests.storage=10Gi \
--set grafana.persistence.enabled=true \
--set grafana.persistence.size=5Gi
Troubleshooting
No Targets in Prometheus?
Ensure your kubelet and cAdvisor metrics are exposed (check kubectl top nodes works).

Grafana Login Issues?
Reset the password:

bash
kubectl patch secret -n monitoring prometheus-stack-grafana -p '{"data":{"admin-password":"'$(echo "newpassword" | base64)'"}}'
Next Steps
Set up alerts in Alertmanager (included in the stack).

Integrate with Loki for logs (your next project?).

Secure Grafana/Prometheus with Ingress + TLS (using Cert-Manager).

Let me know if you hit any snags! Happy monitoring! 📊🔍

---

To expose Prometheus externally (beyond kubectl port-forward), you have several options depending on your use case and security requirements. Here’s how to make Prometheus accessible outside your cluster:

Option 1: Expose via NodePort (Quick & Simple)
Modify the Prometheus service to use NodePort:

bash
kubectl patch svc -n monitoring prometheus-stack-kube-prom-prometheus \
  --type='json' \
  -p='[{"op": "replace", "path": "/spec/type", "value":"NodePort"}]'
Get the NodePort:

bash
kubectl get svc -n monitoring prometheus-stack-kube-prom-prometheus
Look for a port like 30XXX under PORT(S). Access it at:
http://<your-worker-node-ip>:30XXX

Option 2: Ingress + TLS (Recommended for Production)
If you have an Ingress Controller (e.g., Traefik/Nginx) and Cert-Manager installed:

Create an Ingress Resource:

yaml
cat <<EOF | kubectl apply -f -
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: prometheus-ingress
  namespace: monitoring
  annotations:
    cert-manager.io/cluster-issuer: letsencrypt-prod  # Replace with your issuer
    ingress.kubernetes.io/ssl-redirect: "true"
spec:
  ingressClassName: nginx  # Change to your ingress class (e.g., traefik)
  rules:
  - host: prometheus.your-domain.com  # Replace with your domain
    http:
      paths:
      - path: /
        pathType: Prefix
        backend:
          service:
            name: prometheus-stack-kube-prom-prometheus
            port:
              number: 9090
  tls:
  - hosts:
    - prometheus.your-domain.com
    secretName: prometheus-tls
EOF
Access Prometheus securely:
https://prometheus.your-domain.com

Option 3: LoadBalancer (Cloud Providers)
If you’re on AWS/GCP/Azure:

bash
kubectl patch svc -n monitoring prometheus-stack-kube-prom-prometheus \
  --type='json' \
  -p='[{"op": "replace", "path": "/spec/type", "value":"LoadBalancer"}]'
Get the external IP:

bash
kubectl get svc -n monitoring prometheus-stack-kube-prom-prometheus
Access via: http://<EXTERNAL-IP>:9090

Option 4: Basic Auth Proxy (For Security)
Use oauth2-proxy or basic-auth to add authentication:

bash
helm upgrade prometheus-stack prometheus-community/kube-prometheus-stack \
  --namespace monitoring \
  --set prometheus.ingress.enabled=true \
  --set prometheus.ingress.hosts[0]=prometheus.your-domain.com \
  --set prometheus.ingress.annotations."nginx\.ingress\.kubernetes\.io/auth-type"=basic \
  --set prometheus.ingress.annotations."nginx\.ingress\.kubernetes\.io/auth-secret"=prometheus-basic-auth \
  --set prometheus.ingress.annotations."nginx\.ingress\.kubernetes\.io/auth-realm"="Authentication Required"
Create a basic-auth secret:

bash
htpasswd -c auth admin  # Enter password when prompted
kubectl create secret generic prometheus-basic-auth -n monitoring --from-file=auth
Security Notes:
Never expose Prometheus without authentication (it has full read access to your cluster).

For home labs, use NodePort + Firewall rules or Ingress with TLS.

Restrict access via network policies:

yaml
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: restrict-prometheus
  namespace: monitoring
spec:
  podSelector:
    matchLabels:
      app: prometheus
  ingress:
  - from:
    - ipBlock:
        cidr: 192.168.1.0/24  # Allow only your home network
Verify Connectivity
bash
curl -v http://<your-node-ip>:<NodePort>/metrics
# Or with auth:
curl -u admin:password http://<your-node-ip>:<NodePort>/metrics
Let me know if you’d like help configuring a specific method! 🔒
