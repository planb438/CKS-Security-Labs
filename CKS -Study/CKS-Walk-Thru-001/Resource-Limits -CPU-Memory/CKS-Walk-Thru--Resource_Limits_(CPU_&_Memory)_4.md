## Resource Limits (CPU & Memory)

3. Resource Limits (CPU & Memory)

 Purpose
Resource requests and limits ensure:
• Requests: What the pod needs at minimum to start and stay running.

• Limits: The maximum it can use. Beyond this, the pod may get throttled (CPU) or killed (memory).


 Configuration Example
yaml
CopyEdit


resources:
  requests:
    cpu: "100m"
    memory: "128Mi"
  limits:
    cpu: "500m"
    memory: "256Mi"


This block goes under each container: in your pod spec (deployment.yaml, values.yaml, or a Helm template).

Security and Stability Benefits

| Practice | Why It Matters |
| Prevents resource hogs | Avoids noisy-neighbor problems |
| Avoids OOM kills at the node level | Stabilizes memory across pods |
| Helps with HPA metrics | HPA uses CPU usage as a percentage of the requested value |
| Part of Pod Security Best Practices | Many admission controllers (Kyverno, Gatekeeper) require these limits |




Verification



kubectl describe pod <pod-name> -n dev
kubectl top pod -n dev
kubectl get limits -n dev


Optional: Apply a LimitRange to enforce defaults at the namespace level:
yaml



apiVersion: v1
kind: LimitRange
metadata:
  name: resource-limits
  namespace: dev
spec:
  limits:
  - default:
      cpu: 500m
      memory: 256Mi
    defaultRequest:
      cpu: 100m
      memory: 128Mi
    type: Container



โ What You Should Remember
◇ Always set requests and limits for every pod/container.

◇ Use LimitRange for default safety net.

◇ HPA and cluster autoscaling depend on these values.




