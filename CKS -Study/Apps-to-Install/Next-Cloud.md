[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)
[![Platform](https://img.shields.io/badge/platform-Ubuntu%2022.04%2B-lightgrey)](#)
[![Kubernetes](https://img.shields.io/badge/Kubernetes-MicroK8s%20%7C%20kubeadm-blue)](#)
[![YouTube](https://img.shields.io/badge/YouTube-TechShorts-red)](https://www.youtube.com/@adaribain)
[![LinkedIn](https://img.shields.io/badge/LinkedIn-Adari%20Bain-blue)](https://www.linkedin.com/in/adari-bain-298924152/)

Now that your local-path StorageClass is set up, here's a clean, step-by-step guide to install Nextcloud in its own namespace with persistent storage:

1. Create the Namespace
bash
kubectl create namespace nextcloud
2. Create nextcloud-values.yaml
Configure Nextcloud with your StorageClass (local-path):

yaml
# nextcloud-values.yaml
persistence:
  enabled: true
  storageClass: "local-path"  # Uses your pre-configured StorageClass
  size: 10Gi                 # Adjust size as needed

service:
  type: NodePort             # For easy access (or use LoadBalancer/Ingress)

nextcloud:
  host: 10.0.0.101          # Replace with your worker node IP or domain - # Internal IP of any worker node
  username: admin            # Default admin user
  password: "Adm!nP@ss123"   # Change this to a strong password!

# Optional: Enable Redis for caching (recommended)
redis:
  enabled: true
3. Install Nextcloud via Helm
bash
helm repo add nextcloud https://nextcloud.github.io/helm/
helm repo update
helm install nextcloud nextcloud/nextcloud \
  --namespace nextcloud \
  --values nextcloud-values.yaml
4. Verify Resources
Check if pods, PVCs, and services are running:

bash
kubectl get pods,pvc,svc -n nextcloud -o wide
Expected Output:

text
NAME                          READY   STATUS    RESTARTS   AGE
pod/nextcloud-xxxxx           1/1     Running   0          2m
pod/nextcloud-redis-xxxxx     1/1     Running   0          2m

NAME                                STATUS   VOLUME            CAPACITY   AGE
persistentvolumeclaim/nextcloud     Bound    pvc-123456789     10Gi       2m

NAME                 TYPE       CLUSTER-IP     EXTERNAL-IP   PORT(S)        AGE
service/nextcloud    NodePort   10.96.xx.xx    <none>        80:3xxxx/TCP   2m
service/nextcloud-redis ClusterIP None         <none>        6379/TCP       2m
5. Access Nextcloud
Via NodePort:
Get the NodePort assigned to Nextcloud:

bash
kubectl get svc -n nextcloud nextcloud
Example output:

text
NAME        TYPE       CLUSTER-IP    EXTERNAL-IP   PORT(S)        AGE
nextcloud   NodePort   10.96.xx.xx   <none>        80:32456/TCP   5m
Here, the port is 32456.

Access Nextcloud in your browser:
http://<your-worker-node-ip>:32456

Username: admin

Password: As set in nextcloud-values.yaml.

6. Post-Install Configuration
Enable Ingress (Optional):
If you have an Ingress Controller (e.g., Traefik/Nginx), add this to your values.yaml:

yaml
ingress:
  enabled: true
  annotations:
    cert-manager.io/cluster-issuer: letsencrypt-prod   # If using Cert-Manager
  hosts:
    - host: nextcloud.your-domain.com
      paths:
        - path: /
  tls:
    - secretName: nextcloud-tls
      hosts:
        - nextcloud.your-domain.com
Then upgrade:

bash
helm upgrade nextcloud nextcloud/nextcloud \
  --namespace nextcloud \
  --values nextcloud-values.yaml
Enable Automatic Backups:
Use Velero or a cronjob to backup the PVC:

bash
kubectl apply -f https://raw.githubusercontent.com/example/backup-job.yaml
Troubleshooting
PVC Not Bound:

bash
kubectl describe pvc -n nextcloud nextcloud
Ensure local-path pods are running:

bash
kubectl get pods -n local-path-storage
Forgot Password:
Reset via CLI:

bash
kubectl exec -n nextcloud deploy/nextcloud -- sudo -u www-data php occ user:resetpassword admin
Performance Issues:
Scale up resources in values.yaml:

yaml
resources:
  requests:
    memory: "512Mi"
    cpu: "500m"
  limits:
    memory: "1Gi"
    cpu: "1"
Uninstall
bash
helm uninstall nextcloud -n nextcloud
kubectl delete pvc -n nextcloud --all  # Delete data if needed
kubectl delete namespace nextcloud
Next Steps
Install Collabora Online for Office docs:

bash
helm install collabora --namespace nextcloud ...
Set up Nextcloud Talk for video calls.

Let me know if you need adjustments! 🚀

---

Since sudo isn't available in the Nextcloud container, we'll use a direct approach to reset the admin password. Here's how to do it properly:

Password Reset Without Sudo
Access the Nextcloud pod:

bash
kubectl exec -n nextcloud -it deploy/nextcloud -- bash
Navigate to the Nextcloud root directory:

bash
cd /var/www/html
Reset the password using the correct syntax:

bash
php occ user:resetpassword admin
You'll be prompted to enter and confirm a new password.

Example output:

text
Enter a new password: 
Confirm the new password: 
Successfully reset password for admin
Exit the pod:

bash
exit

