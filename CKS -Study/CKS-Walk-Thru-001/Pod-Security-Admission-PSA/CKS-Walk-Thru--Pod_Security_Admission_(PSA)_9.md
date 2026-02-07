## Pod Security Admission (PSA)

---

Great lets dive into Pod Security Admission (PSA). This is a core Kubernetes-native mechanism for enforcing pod-level security, replacing the deprecated PodSecurityPolicy (PSP).

 very CKS-relevant, and lightweight compared to third-party policy engines like Kyverno or OPA/Gatekeeper.

---

Pod Security Admission (PSA) Overview

Purpose
PSA enforces predefined security profiles (privileged, baseline, restricted) at the namespace level to control what types of pods can run.

 PSA Modes & Profiles

| Profile | Trust Level | Blocks |
| privileged | Least restrictive | Nothing |
| baseline | Medium | Most known-dangerous options |
| restricted | Most secure | Blocks hostPath, privileged, capabilities, etc. |



Each namespace can enforce these in three ways:
• enforce actively blocks violations

• audit logs violations

• warn shows warnings to clients



 Enabling PSA (Already built-in in 1.25+)
No need to install anything.
To secure a namespace (e.g. dev) with restricted mode:
bash
CopyEdit


kubectl label namespace dev \
  pod-security.kubernetes.io/enforce=restricted \
  pod-security.kubernetes.io/audit=baseline \
  pod-security.kubernetes.io/warn=baseline


Verify:


kubectl get ns dev --show-labels



Test It
Try to deploy a privileged pod (this should be blocked):



apiVersion: v1
kind: Pod
metadata:
  name: bad-pod
spec:
  containers:
  - name: bad
    image: busybox
    command: ["sleep", "3600"]
    securityContext:
      privileged: true





kubectl apply -f bad-pod.yaml -n dev


You should see an error like:



Error from server: pod "bad-pod" is forbidden: violates PodSecurity "restricted:latest"

---

PSA Tips for the CKS

| Practice | Why It Matters |
| Use restricted in all namespaces except trusted ones | Blocks dangerous configs |
| Add audit and warn in dev to learn impact | See violations without blocking |
| Combine PSA with Kyverno/Gatekeeper later | Layered security policies |
| Always label new namespaces immediately | Default is no enforcement |




 What You Should Remember
◇ PSA replaces PodSecurityPolicies.

◇ Namespace labels drive enforcement easy to forget!

◇ Use restricted for the best security posture.


Want to move on to Secrets Encryption at Rest next?


