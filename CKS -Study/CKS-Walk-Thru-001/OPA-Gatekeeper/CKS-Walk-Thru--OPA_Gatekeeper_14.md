[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)
[![Platform](https://img.shields.io/badge/platform-Ubuntu%2022.04%2B-lightgrey)](#)
[![Kubernetes](https://img.shields.io/badge/Kubernetes-MicroK8s%20%7C%20kubeadm-blue)](#)
[![YouTube](https://img.shields.io/badge/YouTube-TechShorts-red)](https://www.youtube.com/@adaribain)
[![LinkedIn](https://img.shields.io/badge/LinkedIn-Adari%20Bain-blue)](https://www.linkedin.com/in/adari-bain-298924152/)

## OPA Gatekeeper

ðŸ§  OPA Gatekeeper Overview
Gatekeeper uses:
• Custom Resource Definitions (CRDs) like ConstraintTemplates and Constraints

• Rego language to write policies

• Admission controller webhooks (like Kyverno) to enforce policy decisions



ðŸ“¦ Step 1: Install OPA Gatekeeper
bash
CopyEdit


kubectl apply -f https://raw.githubusercontent.com/open-policy-agent/gatekeeper/release-3.15/deploy/gatekeeper.yaml


âœ… This will create a gatekeeper-system namespace and deploy controller pods.
Check the pods:
bash
CopyEdit


kubectl get pods -n gatekeeper-system



ðŸ”¨ Step 2: Deploy a Sample ConstraintTemplate
Letâ€™s install a policy that disallows privileged pods, similar to Kyverno â€” but now using Rego.
yaml
CopyEdit


# templates/privileged-container-template.yaml
apiVersion: templates.gatekeeper.sh/v1beta1
kind: ConstraintTemplate
metadata:
  name: k8sdisallowedprivileged
spec:
  crd:
    spec:
      names:
        kind: K8sDisallowedPrivileged
  targets:
    - target: admission.k8s.gatekeeper.sh
      rego: |
        package k8sdisallowedprivileged

        violation[{"msg": msg}] {
          input.review.kind.kind == "Pod"
          container := input.review.object.spec.containers[_]
          container.securityContext.privileged == true
          msg := "Privileged containers are not allowed"
        }


Apply it:
bash
CopyEdit


kubectl apply -f privileged-container-template.yaml



ðŸ§± Step 3: Create the Constraint to Enforce It
yaml
CopyEdit


# constraints/privileged-container-constraint.yaml
apiVersion: constraints.gatekeeper.sh/v1beta1
kind: K8sDisallowedPrivileged
metadata:
  name: disallow-privileged-containers
spec:
  match:
    kinds:
      - apiGroups: [""]
        kinds: ["Pod"]


Apply:
bash
CopyEdit


kubectl apply -f privileged-container-constraint.yaml



ðŸ§ª Step 4: Test with a Privileged Pod
Use the same pod test file as with Kyverno (privileged: true). Gatekeeper should now reject the request with a policy violation error.
Let me know once Gatekeeper is successfully installed and the test works â€” then weâ€™ll head into Private Registries and ImagePullSecrets. Ready?


