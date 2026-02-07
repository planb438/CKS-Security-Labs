### Part 3: Seccomp (RuntimeDefault)

✅ Part 3: Seccomp (RuntimeDefault)
File: 3-seccomp-runtime.yaml
yaml
CopyEdit


apiVersion: v1
kind: Pod
metadata:
  name: seccomp-default
  namespace: secdemo
spec:
  securityContext:
    seccompProfile:
      type: RuntimeDefault
  containers:
  - name: nginx
    image: nginx
    command: ["sleep", "3600"]
    securityContext:
      allowPrivilegeEscalation: false
      capabilities:
        drop: ["ALL"]


Test:
bash
CopyEdit


kubectl apply -f 3-seccomp-runtime.yaml
kubectl get pod seccomp-default -n secdemo -o jsonpath='{.spec.securityContext.seccompProfile.type}'
# Expect: RuntimeDefault



