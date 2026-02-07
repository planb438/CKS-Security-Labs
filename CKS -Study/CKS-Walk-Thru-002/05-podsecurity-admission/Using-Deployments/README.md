Absolutely — here’s your updated scenario rewritten using Deployments instead of Pods, tailored for CKS preparation and aligned with what you likely saw in the exam.

✅ Updated PSA Scenario Using Deployments

---

🧪 How to Test It
bash
Copy
Edit
# Create the namespace with PSA enforced
kubectl apply -f ns-restricted.yaml

# Try the insecure deployment (should be blocked)
kubectl apply -f bad-deployment.yaml

# Try the secure deployment (should be allowed)
kubectl apply -f good-deployment.yaml
🧼 Cleanup
bash
Copy
Edit
kubectl delete ns psa-test
