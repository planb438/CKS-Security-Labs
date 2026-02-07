[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)
[![Platform](https://img.shields.io/badge/platform-Ubuntu%2022.04%2B-lightgrey)](#)
[![Kubernetes](https://img.shields.io/badge/Kubernetes-MicroK8s%20%7C%20kubeadm-blue)](#)
[![YouTube](https://img.shields.io/badge/YouTube-TechShorts-red)](https://www.youtube.com/@adaribain)
[![LinkedIn](https://img.shields.io/badge/LinkedIn-Adari%20Bain-blue)](https://www.linkedin.com/in/adari-bain-298924152/)

## Falco

Falco: Runtime Threat Detection

---

 What it does
Falco watches syscalls from the Linux kernel (via eBPF or a kernel module) and alerts when suspicious behavior happens in your containers or host.
Examples:
• A shell is spawned inside a container (bash, sh)

• A sensitive file is read (/etc/shadow)

• Unexpected network access or privilege escalation



Step-by-Step: Install Falco (Helm-based)

---

1. Add the Falco Helm repo
bash
CopyEdit


helm repo add falcosecurity https://falcosecurity.github.io/charts
helm repo update

--

 2. Create a dedicated namespace


kubectl create namespace falco

--

 3. Install Falco with Helm



helm install falco falcosecurity/falco -n falco


Want to avoid eBPF errors? Make sure your kernel supports it. If unsure, Falco will fall back to the kernel module.

--

 4. Verify it's running



kubectl get pods -n falco


You should see something like:
sql



NAME                     READY   STATUS    RESTARTS   AGE
falco-abc123             1/1     Running   0          10s



Test It: Trigger a Falco Alert
Letâ simulate a container running a shell this is something Falco should block/alert on.



kubectl run test-shell --rm -it --image=alpine -- sh


If bash isn available, try sh instead.
Falco will generate a log/alert that looks like:



22:01:25.218809744: Notice A shell was spawned in a container with an attached terminal


You can check logs:



kubectl logs -l app.kubernetes.io/name=falco -n falco -c falco 

---

 What Falco Catches

| Rule Example | Description |
| Launch Shell in Container | Someone enters a shell inside a pod |
| Read Sensitive File Untrusted | Accessing /etc/shadow, /proc/kcore |
| Write below etc | Modifying configs |
| Create Symlink to Sensitive Path | Escaping via symlinks |
| Inbound Connections to High Ports | Suspicious network access |




--

  CKS Tip
◇ Falco is detection, not prevention (like IDS)

◇ Use it with Slack, webhook, or file output for alerting

◇ Bonus: You can create custom rules for your app


Let verify it's working and test an alert. Do you want to walk through a custom rule or move to network policies (Cilium) next?


Great  lets verify Falco is working and then trigger a known alert. Heres a clean walkthrough 

--

Step 1: Confirm Falco is Running



kubectl get pods -n falco


You should see something like:
sql



NAME                   READY   STATUS    RESTARTS   AGE
falco-xxxxx            1/1     Running   0          1m


If not running, run kubectl describe pod <name> -n falco to troubleshoot.

--

Step 2: View Falco Logs (Live)
Let watch the logs to catch alerts in real time:



kubectl logs -n falco -l app=falco -f


Leave that running in one terminal/tab.

--

Step 3: Trigger a Falco Rule (Shell Spawned in Container)
In a second terminal/tab, run this to simulate an intrusion:



kubectl run test-shell --rm -it --image=alpine -- sh


Once inside the shell, press enter a few times, then exit (Ctrl+D).

--

Step 4: Look for This Alert in the Logs
In your first terminal (where Falco logs are streaming), you should see something like:
css



Notice A shell was spawned in a container with an attached terminal


This confirms Falco intercepted and flagged the syscall.

--

Cleanup
No cleanup needed  --rm deleted the pod automatically.
Let me know if you see the alert in your logs or if you want to try a second test like accessing a sensitive file inside a container. Want to test that too?




