### Part 4: AppArmor Profile (Ubuntu Only)

Part 4: AppArmor Profile (Ubuntu Only)
Create Local Profile:
bash
CopyEdit


echo -e "profile deny-write-tmp flags=(attach_disconnected) {\n  deny /tmp/** w,\n}" | sudo tee /etc/apparmor.d/deny-write-tmp
sudo apparmor_parser -r /etc/apparmor.d/deny-write-tmp


File: 4-apparmor-pod.yaml
yaml
CopyEdit


apiVersion: v1
kind: Pod
metadata:
  name: apparmor-pod
  namespace: secdemo
  annotations:
    container.apparmor.security.beta.kubernetes.io/nginx: localhost/deny-write-tmp
spec:
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


kubectl apply -f 4-apparmor-pod.yaml
kubectl exec -n secdemo -it apparmor-pod -- touch /tmp/testfile
# Expect: Permission denied


Would you like me to now continue with Parts 5â7 for:
• Privileged pods

• Capability/hostPath restrictions

• Namespace isolation examples


Letâs keep building your master workbook. Ready to continue?













You said:
before moving forwadr i would like to undo apparmor changes












Absolutely âhere's how to safely undo the AppArmor changes you made:

 Undo AppArmor Profile Configuration

 Step 1: Delete the Pod Using the AppArmor Profile



kubectl delete pod apparmor-pod -n secdemo



 Step 2: Remove the Custom AppArmor Profile from the Node
If you're using Ubuntu and the profile was named deny-write-tmp, remove it like this:



sudo rm /etc/apparmor.d/deny-write-tmp


Then reload AppArmor to unregister it:



sudo apparmor_parser -R /etc/apparmor.d/deny-write-tmp 2>/dev/null || true


ðTip: If the profile is still loaded, you can confirm and remove it using:


sudo aa-status  # List loaded profiles



Optional: Restart AppArmor Service (if needed)


sudo systemctl restart apparmor


Thats it âyour system is now clean of the custom AppArmor test profile.
Ready to continue with capability hardening, privileged pod examples, and namespace restrictions?















