### Full Gatekeeper Uninstall Steps
🔥 Option B: Fully Uninstall Kyverno
If you won’t need Kyverno for the rest of this session:
bash
CopyEdit


helm uninstall kyverno -n kyverno
kubectl delete ns kyverno


Verify cleanup:
bash
CopyEdit


kubectl get validatingwebhookconfigurations | grep kyverno
kubectl get mutatingwebhookconfigurations | grep kyverno


Remove any leftover webhook configs:
bash
CopyEdit


kubectl delete validatingwebhookconfiguration kyverno-policy-validating-webhook-cfg --ignore-not-found
kubectl delete mutatingwebhookconfiguration kyverno-policy-mutating-webhook-cfg --ignore-not-found



===================================================================================================


Perfect — here’s how to fully uninstall OPA Gatekeeper from your cluster.

🔥 Full Gatekeeper Uninstall Steps
Run the following in order:

1. 🗑️ Uninstall Gatekeeper Core Components
bash
CopyEdit


kubectl delete -f https://raw.githubusercontent.com/open-policy-agent/gatekeeper/release-3.15/deploy/gatekeeper.yaml


This removes all Gatekeeper controllers, webhooks, and CRDs.

2. 🧹 Clean Up Constraints & Templates (If Any Left)
Check and delete any leftovers:
bash
CopyEdit


kubectl get constraints.constraints.gatekeeper.sh
kubectl get constrainttemplates.templates.gatekeeper.sh


If anything still exists:
bash
CopyEdit


kubectl delete constrainttemplates --all
kubectl delete constraints --all



3. 🚮 Delete the Namespace (Optional but Clean)
bash
CopyEdit


kubectl delete ns gatekeeper-system --ignore-not-found



4. ✅ Confirm Cleanup
Make sure no Gatekeeper-related webhook configs remain:
bash
CopyEdit


kubectl get validatingwebhookconfigurations | grep gatekeeper
kubectl get mutatingwebhookconfigurations | grep gatekeeper


If any still exist (rare), delete manually:
bash
CopyEdit


kubectl delete validatingwebhookconfiguration <name>
kubectl delete mutatingwebhookconfiguration <name>





