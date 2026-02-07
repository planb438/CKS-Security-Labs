## Prometheus & Grafana Setup
Perfect — let’s move on to Prometheus & Grafana, your observability stack. These tools give you real-time visibility into your cluster’s health, performance, and resource usage — essential for troubleshooting and security auditing (important for CKS too).

✅ Prometheus & Grafana Setup

🔍 Purpose
• Prometheus: Scrapes metrics from Kubernetes components, nodes, apps, etc.

• Grafana: Visualizes metrics through dashboards and alerts.



🛠 Step-by-Step: Install via Helm
We'll use the kube-prometheus-stack (by Bitnami or Prometheus Community), which bundles:
◇ Prometheus

◇ Alertmanager

◇ Grafana

◇ Node exporters

◇ ServiceMonitors, CRDs



1. Add Helm repo & update
bash
CopyEdit


helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo update



2. Install into monitoring namespace
bash
CopyEdit


kubectl create namespace monitoring

helm install kps prometheus-community/kube-prometheus-stack \
  --namespace monitoring



3. Wait for pods to be ready
bash
CopyEdit


kubectl get pods -n monitoring


Look for:
◇ prometheus-kps-prometheus-*

◇ grafana-*

◇ alertmanager-*



🧪 Access Grafana (NodePort Method)
1. Get NodePort (or port-forward)

bash
CopyEdit


kubectl get svc -n monitoring


Look for kps-grafana, usually exposed as ClusterIP. You can:
◇ Expose it manually as NodePort:
bash
CopyEdit


kubectl patch svc kps-grafana -n monitoring -p '{"spec":{"type":"NodePort"}}'


Then find the NodePort (e.g., 30080).

◇ Or just port-forward temporarily:
bash
CopyEdit


kubectl port-forward svc/kps-grafana 3000:80 -n monitoring




1. Login to Grafana

Go to http://localhost:3000 or http://<worker-node>:<NodePort>
Default credentials:
◇ Username: admin

◇ Password: auto-generated in secret:


bash
CopyEdit


kubectl get secret kps-grafana -n monitoring -o jsonpath="{.data.admin-password}" | base64 --decode



📊 Built-in Dashboards
Grafana will automatically show dashboards like:
◇ Cluster Health

◇ Pod Resource Usage

◇ Node CPU/Memory

◇ API Server Metrics



🔐 Security Best Practices

| Practice | Why It Matters |
| Change default admin credentials | Prevent unauthorized access |
| Secure Grafana behind Ingress+TLS | Avoid HTTP dashboard access |
| Enable Prometheus alerting (e.g., CPU spike, pod restarts) | For automated incident response |
| Limit Prometheus retention (in dev) | Avoid disk bloat |




✅ What You Should Remember
◇ Prometheus scrapes, Grafana visualizes.

◇ This stack is key for audit trails, performance tuning, and security alerts.

◇ Port-forward in home labs, or use NodePort + /etc/hosts for UI access.


Ready to proceed to Pod Security Admission (PSA) next


