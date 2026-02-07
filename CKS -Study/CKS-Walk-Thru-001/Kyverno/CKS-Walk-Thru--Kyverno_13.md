## Kyverno

🧩 Next Step: Kyverno – Kubernetes Native Policy Engine
Kyverno lets you:
• Enforce security policies (e.g., no :latest tags, disallow privileged pods)

• Automatically mutate or validate incoming resources

• Easily write policies in YAML (no Rego needed)



📦 Step 1: Install Kyverno via Helm
bash
CopyEdit


helm repo add kyverno https://kyverno.github.io/kyverno/
helm repo update

helm install kyverno kyverno/kyverno \
  --namespace kyverno \
  --create-namespace


✅ Once installed:
bash
CopyEdit


kubectl get pods -n kyverno



🧪 Step 2: Create a Simple Validation Policy
Let's create a policy that blocks containers running as root.
yaml
CopyEdit


# disallow-privileged.yaml
apiVersion: kyverno.io/v1
kind: ClusterPolicy
metadata:
  name: disallow-privileged
spec:
  validationFailureAction: enforce
  rules:
    - name: check-privileged
      match:
        resources:
          kinds:
            - Pod
      validate:
        message: "Privileged containers are not allowed!"
        pattern:
          spec:
            containers:
              - securityContext:
                  privileged: "false"


Apply it:
bash
CopyEdit


kubectl apply -f disallow-privileged.yaml



🔍 Step 3: Test the Policy
Try running a pod with privileged mode:
yaml
CopyEdit


# privileged-pod.yaml
apiVersion: v1
kind: Pod
metadata:
  name: naughty
spec:
  containers:
    - name: cks
      image: busybox
      command: ["sh", "-c", "sleep 3600"]
      securityContext:
        privileged: true


Apply it:
bash
CopyEdit


kubectl apply -f privileged-pod.yaml


✅ Kyverno should block it with a validation error.
Let me know once you've tested this — then we’ll jump to OPA Gatekeeper (Rego-based alternative). Ready?




4o













