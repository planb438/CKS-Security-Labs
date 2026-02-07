## Liveness and Readiness Probes

✅ 2. Liveness and Readiness Probes

🔍 Purpose
• Liveness Probe: Detects if a container is stuck or dead. If it fails, Kubernetes restarts the pod.

• Readiness Probe: Determines if the container is ready to serve traffic. If it fails, the pod is temporarily removed from service (e.g., from a Service load balancer).



🛠 How to Configure (Sample YAML)
yaml
CopyEdit


livenessProbe:
  httpGet:
    path: /healthz
    port: 3000
  initialDelaySeconds: 10
  periodSeconds: 5
  failureThreshold: 3

readinessProbe:
  httpGet:
    path: /readyz
    port: 3000
  initialDelaySeconds: 5
  periodSeconds: 5
  failureThreshold: 2


Attach these under your container spec in your Helm chart’s values.yaml or deployment.yaml.

🔐 Security Considerations

| Practice | Explanation |
| Don’t expose probe endpoints externally | Use local-only paths like /healthz, and don’t route them through Ingress |
| Avoid using exec probes in production | They’re slower and can expose shell command execution risks |
| Validate probe stability under load | Make sure they don’t go down during spikes unless the app is truly unhealthy |




🧪 How to Test
bash
CopyEdit


kubectl describe pod <pod-name> -n dev
kubectl get events -n dev
kubectl get endpoints


Or, force a failure in your app and observe automatic pod restarts.

✅ What You Should Remember
◇ Probes are essential for self-healing and zero-downtime deployments.

◇ Incorrect probes can lead to cascading failures (restarts or premature traffic routing).

◇ Tailor probe timings to app startup/warm-up characteristics.




