### Part 1: No Security Context (Insecure Baseline)
ile: 1-insecure-pod.yaml
yaml
CopyEdit


apiVersion: v1
kind: Pod
metadata:
  name: insecure-pod
  namespace: secdemo
spec:
  containers:
  - name: nginx
    image: nginx
    command: ["sleep", "3600"]


Test:
bash
CopyEdit


kubectl create ns secdemo
kubectl apply -f 1-insecure-pod.yaml
kubectl exec -n secdemo -it insecure-pod -- id  # Expect UID 0 (root)


