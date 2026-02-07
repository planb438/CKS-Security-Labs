### Part 2: Hardened Pod — Pod & Container Security Context

✅ Part 2: Hardened Pod — Pod & Container Security Context
File: 2-secure-pod.yaml
yaml
CopyEdit


apiVersion: v1
kind: Pod
metadata:
  name: secure-pod
  namespace: secdemo
spec:
  securityContext:
    runAsUser: 1000
    runAsGroup: 3000
    fsGroup: 2000
  containers:
  - name: nginx
    image: nginx
    command: ["sleep", "3600"]
    securityContext:
      allowPrivilegeEscalation: false
      readOnlyRootFilesystem: true
      runAsNonRoot: true
      capabilities:
        drop: ["ALL"]


Test:
bash
CopyEdit


kubectl apply -f 2-secure-pod.yaml
kubectl exec -n secdemo -it secure-pod -- id
kubectl exec -n secdemo -it secure-pod -- mount | grep /etc




