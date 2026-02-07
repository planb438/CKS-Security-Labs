[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)
[![Platform](https://img.shields.io/badge/platform-Ubuntu%2022.04%2B-lightgrey)](#)
[![Kubernetes](https://img.shields.io/badge/Kubernetes-MicroK8s%20%7C%20kubeadm-blue)](#)
[![YouTube](https://img.shields.io/badge/YouTube-TechShorts-red)](https://www.youtube.com/@adaribain)
[![LinkedIn](https://img.shields.io/badge/LinkedIn-Adari%20Bain-blue)](https://www.linkedin.com/in/adari-bain-298924152/)

## Horizontal Pod Autoscaler (HPA)

ChatGPT said:
Great! Let continue with the Horizontal Pod Autoscaler (HPA) a key mechanism for dynamic scaling based on resource usage.

4. Horizontal Pod Autoscaler (HPA)

Purpose
HPA automatically adjusts the number of pod replicas in a deployment based on observed CPU (or memory/custom metrics) usage.

 Prerequisites
• Metrics Server must be installed and running.


kubectl get deployment metrics-server -n kube-system

 HPA Example for CPU-based Scaling
yaml


apiVersion: autoscaling/v2
kind: HorizontalPodAutoscaler
metadata:
  name: node-app-hpa
  namespace: dev
spec:
  scaleTargetRef:
    apiVersion: apps/v1
    kind: Deployment
    name: node-app
  minReplicas: 2
  maxReplicas: 5
  metrics:
  - type: Resource
    resource:
      name: cpu
      target:
        type: Utilization
        averageUtilization: 50


You can also generate it with kubectl:

kubectl autoscale deployment node-app --cpu-percent=50 --min=2 --max=5 -n dev



Security and Operational Notes

| Practice | Why It Matters |
| Donβt set maxReplicas too high | Avoid DoS via runaway scaling |
| Validate metrics before relying on HPA | Ensure metrics-server is stable |
| Always define CPU requests | HPA uses requested CPU as baseline |
| Watch for flapping | Use stabilizationWindowSeconds if needed in autoscaling/v2 |



 Verification
t


kubectl get hpa -n dev
kubectl describe hpa node-app-hpa -n dev
kubectl top pods -n dev


Optional: Load test the app using hey, ab, or k6 to observe scaling in action.
What You Should Remember
◇ HPA is effective when paired with correct resource requests.

◇ You can use custom metrics with Prometheus Adapter later.

◇ Ensure metrics-server is healthy itβs your HPA heartbeat.












