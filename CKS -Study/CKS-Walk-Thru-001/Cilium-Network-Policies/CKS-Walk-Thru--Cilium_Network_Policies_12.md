[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)
[![Platform](https://img.shields.io/badge/platform-Ubuntu%2022.04%2B-lightgrey)](#)
[![Kubernetes](https://img.shields.io/badge/Kubernetes-MicroK8s%20%7C%20kubeadm-blue)](#)
[![YouTube](https://img.shields.io/badge/YouTube-TechShorts-red)](https://www.youtube.com/@adaribain)
[![LinkedIn](https://img.shields.io/badge/LinkedIn-Adari%20Bain-blue)](https://www.linkedin.com/in/adari-bain-298924152/)

## Cilium Network Policies

---



⏭ Next Up: Cilium Network Policies
We'll now move into enforcing pod-to-pod communication rules — a core CKS topic and real-world skill.
Ready to begin with network policy basics and Cilium setup validation?


-

Awesome — let’s lock down pod-to-pod communication using Cilium 🔒🐡

🌐 Step 1: Validate Cilium Is Installed & Managing Networking
First, make sure Cilium is up and running.

-


kubectl get pods -n kube-system -l k8s-app=cilium

-

You should see one Cilium pod per node:

--

NAME           READY   STATUS    RESTARTS   AGE
cilium-abc1    1/1     Running   0          3d
cilium-def2    1/1     Running   0          3d

--

You can also check the CNI config:

-
kubectl get daemonset cilium -n kube-system
-

If it’s not installed yet, we’ll install it — just let me know.
-
🔐 Step 2: Create Two Test Pods in a Namespace Let’s create a namespace and two pods to simulate isolated microservices.

-

kubectl create ns netpol-demo
-

Now apply this YAML:

-
apiVersion: v1
kind: Pod
metadata:
  name: busybox-client
  namespace: netpol-demo
  labels:
    app: client
spec:
  containers:
  - name: bb
    image: busybox
    command: ["sleep", "3600"]


---
apiVersion: v1
kind: Pod
metadata:
  name: nginx-server
  namespace: netpol-demo
  labels:
    app: web
spec:
  containers:
  - name: nginx
    image: nginx

-
Apply with:

-
kubectl apply -f <filename>.yaml

-
Or paste directly into kubectl apply -f -.

-
🔎 Step 3: Test Communication (Pre-NetworkPolicy)
Wait a few seconds for the pods to come up, then exec into the client:

-
kubectl get pods -n netpol-demo -o wide
-
kubectl exec -n netpol-demo busybox-client -- wget -qO- (nginx-server) ## the ip address of the nginx-server
-

You should see NGINX HTML output — this confirms communication works before a policy is applied.
Shall we now write a NetworkPolicy to block all traffic and then selectively allow it?
-

Welcome back — great work resolving both the Falco logging issue and Cilium DNS problem! You're right where we left off:
You verified:
• busybox-client can reach nginx-server ✅

• So networking works before a policy is applied ✅

-


🔒 Step: Apply a Default Deny NetworkPolicy
Let’s now block all ingress traffic to nginx-server.

-
1️⃣ Create a default deny policy:
-


# deny-all.yaml
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: deny-all-ingress
  namespace: netpol-demo
spec:
  podSelector: {}
  policyTypes:
  - Ingress



Apply it:



kubectl apply -f deny-all.yaml



2️⃣ Re-test Connection (Should Fail)
Try the client again:



kubectl exec -n netpol-demo busybox-client -- wget -qO- <nginx-server IP>


✅ Expected result: Connection fails (hangs or connection refused)

🎯 Next: Allow Specific Ingress
After that, we’ll write a second policy to allow ingress only from the busybox client pod by label.
Let me know once deny-all is in place and traffic is blocked — then we’ll allow traffic selectively. Ready?




Awesome — let’s now write a NetworkPolicy that allows only the busybox-client pod to access nginx-server.

✅ Step: Allow Specific Ingress From Labeled Client

1️⃣ Label the busybox pod (if not already):
bash
CopyEdit


kubectl label pod busybox-client -n netpol-demo app=client



2️⃣ Apply the allow-from-client policy:
yaml
CopyEdit


# allow-from-client.yaml
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: allow-from-client
  namespace: netpol-demo
spec:
  podSelector:
    matchLabels:
      app: nginx
  policyTypes:
    - Ingress
  ingress:
    - from:
        - podSelector:
            matchLabels:
              app: client


Apply it:
bash
CopyEdit


kubectl apply -f allow-from-client.yaml



🔁 Test Again (Should Work Now)
bash
CopyEdit


kubectl exec -n netpol-demo busybox-client -- wget -qO- <nginx-server IP>


✅ You should now see the NGINX welcome HTML again — proving traffic is allowed only from that labeled pod.
Let me know when confirmed, and we’ll optionally test by spinning up a second, unlabeled pod to show it’s blocked. Want to try that next?




Perfect — let’s prove the policy is working by trying to access the nginx-server from a pod without the required label.

🚫 Step: Test from an Unlabeled Pod (Should Fail)

1️⃣ Run an unlabeled pod:


kubectl run unlabeled-client --image=busybox:1.28 -n netpol-demo --rm -it --restart=Never -- sh


Then from inside the shell:
sh


wget -qO- <nginx-server IP>


✅ Expected result: The request fails (hangs or gets connection refused).
This demonstrates that:
• The NetworkPolicy is working

• Only pods with app=client label are allowed in


Would you like to try egress policies next, or move on to the next security task (like Secrets Encryption or Kyverno)?
























