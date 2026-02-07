[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)
[![Platform](https://img.shields.io/badge/platform-Ubuntu%2022.04%2B-lightgrey)](#)
[![Kubernetes](https://img.shields.io/badge/Kubernetes-MicroK8s%20%7C%20kubeadm-blue)](#)
[![YouTube](https://img.shields.io/badge/YouTube-TechShorts-red)](https://www.youtube.com/@adaribain)
[![LinkedIn](https://img.shields.io/badge/LinkedIn-Adari%20Bain-blue)](https://www.linkedin.com/in/adari-bain-298924152/)

### Full Gatekeeper Uninstall Steps
---

Perfect — here’s how to fully uninstall OPA Gatekeeper from your cluster.

--
🔥 Full Gatekeeper Uninstall Steps
Run the following in order:

1. 🗑️ Uninstall Gatekeeper Core Components
-


kubectl delete -f https://raw.githubusercontent.com/open-policy-agent/gatekeeper/release-3.15/deploy/gatekeeper.yaml

--

This removes all Gatekeeper controllers, webhooks, and CRDs.

2. 🧹 Clean Up Constraints & Templates (If Any Left)
Check and delete any leftovers:
--


kubectl get constraints.constraints.gatekeeper.sh
kubectl get constrainttemplates.templates.gatekeeper.sh

--

If anything still exists:

-


kubectl delete constrainttemplates --all
kubectl delete constraints --all

-


3. 🚮 Delete the Namespace (Optional but Clean)
--


kubectl delete ns gatekeeper-system --ignore-not-found

--


4. ✅ Confirm Cleanup
Make sure no Gatekeeper-related webhook configs remain:
--


kubectl get validatingwebhookconfigurations | grep gatekeeper
kubectl get mutatingwebhookconfigurations | grep gatekeeper

--

If any still exist (rare), delete manually:

--


kubectl delete validatingwebhookconfiguration <name>
kubectl delete mutatingwebhookconfiguration <name>

--




