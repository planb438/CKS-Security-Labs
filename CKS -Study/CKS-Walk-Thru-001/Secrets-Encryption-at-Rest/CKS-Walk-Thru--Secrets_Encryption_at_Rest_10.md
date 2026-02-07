## Secrets Encryption at Rest
Awesome etโs move on to Secrets Encryption at Rest ๐ a high-priority CKS topic and a key layer of protection for sensitive data like passwords, tokens, and private keys stored in etcd.

Secrets Encryption at Rest

 Why it matters
• Kubernetes stores secrets in etcd, and by default, they are only base64-encoded, not encrypted.

• If someone gets access to your etcd data (or backup), they can read secrets in plaintext.

• Enabling encryption ensures secrets are encrypted using a secure key before theye written to disk.



 Step-by-Step Setup

1. Create an encryption config file
SSH into your control plane node and create this config:



sudo nano /etc/kubernetes/encryption-config.yaml


Paste the following:



apiVersion: apiserver.config.k8s.io/v1
kind: EncryptionConfiguration
resources:
  - resources:
      - secrets
    providers:
      - aescbc:
          keys:
            - name: key1
              secret: <32-byte-base64-key>
      - identity: {}


Generate a 32-byte base64-encoded key:



head -c 32 /dev/urandom | base64


Paste that key where <32-byte-base64-key> is.

2. Update kube-apiserver manifest
Edit the kube-apiserver static pod config:



sudo nano /etc/kubernetes/manifests/kube-apiserver.yaml


Add this flag to the command section:



--encryption-provider-config=/etc/kubernetes/encryption-config.yaml


Then save and exit. The kubelet will auto-restart the API server.

3. Confirm itโs working
Create a test secret:



kubectl create secret generic test-secret \
  --from-literal=password=CKSrocks123 -n dev


Get the etcd path of that secret:



ETCDCTL_API=3 etcdctl get \
  /registry/secrets/dev/test-secret \
  --cacert=/etc/kubernetes/pki/etcd/ca.crt \
  --cert=/etc/kubernetes/pki/etcd/server.crt \
  --key=/etc/kubernetes/pki/etcd/server.key \
  | hexdump -C


If the secret is not readable in plain text, encryption is working.

4. (Optional) Re-encrypt existing secrets
To encrypt already stored secrets (optional but good practice):


kubectl get secrets -A -o json | \
jq -c '.items[] | {kind: .kind, apiVersion: .apiVersion, metadata: {name: .metadata.name, namespace: .metadata.namespace}, data: .data, type: .type}' | \
while read -r secret; do
  ns=$(echo "$secret" | jq -r '.metadata.namespace')
  name=$(echo "$secret" | jq -r '.metadata.name')
  echo "Re-writing secret $ns/$name"
  echo "$secret" | kubectl apply -f -
done



๐ Security Best Practices

| Practice | Why It Matters |
| Encrypt secrets in all clusters | Default is insecure |
| Rotate keys periodically | Minimize exposure from leaks |
| Limit etcd access | Only to kube-apiserver and etcd admin |
| Donโt store encryption config in Git | Contains encryption keys |




โ What You Should Remember
◇ Secrets in etcd are not encrypted by default.

◇ A static pod change + encryption config enables secure storage.

◇ Test via etcdctl and re-encrypt existing secrets if needed.


Ready to continue with Falco Runtime Security next?



======================================================================================================================




🔐 Next Priority: Secrets Encryption at Rest (Revisit)
Earlier, we skipped it due to a crash caused by a missing config file. You’ve chosen Option B (manual setup with backup precautions). Let’s walk through it safely.

🧾 Step-by-Step: Enable Secrets Encryption at Rest (Option B)
Back up /etc/kubernetes/manifests/kube-apiserver.yaml before editing it.

1️⃣ Generate an encryption key:


head -c 32 /dev/urandom | base64


Copy the output — you’ll paste it into the config file.

2️⃣ Create the encryption config file:


sudo nano /etc/kubernetes/encryption-config.yaml


Paste the following, replacing REPLACE_WITH_BASE64_KEY:



apiVersion: apiserver.config.k8s.io/v1
kind: EncryptionConfiguration
resources:
  - resources:
      - secrets
    providers:
      - aescbc:
          keys:
            - name: key1
              secret: REPLACE_WITH_BASE64_KEY
      - identity: {}



3️⃣ Edit the kube-apiserver manifest:



sudo nano /etc/kubernetes/manifests/kube-apiserver.yaml


Under containers.command, add this flag:


--encryption-provider-config=/etc/kubernetes/encryption-config.yaml


Save and exit. Kubelet will auto-restart the API server.

4️⃣ Verify the API Server is Running:



kubectl get pods -A


If it fails, check:



sudo crictl ps -a | grep kube-apiserver
sudo crictl logs <api-server-container-id>


Once it’s stable, we’ll:
• Create a new secret

• Dump etcd to confirm it’s encrypted


Let me know once the API server is back up after the change, and I’ll walk you through verification. Ready to proceed?






ChatGPT said:
Awesome! Let's now verify that secrets are encrypted in etcd.

🧪 Step 1: Create a Test Secret
bash
CopyEdit


kubectl create secret generic test-secret \
  --from-literal=password=CKSrocks123 -n default



📦 Step 2: Get the Secret from etcd (base64-encoded)
Run this command on the control plane node (where etcd stores data):
bash
CopyEdit


sudo ETCDCTL_API=3 etcdctl get \
  /registry/secrets/default/test-secret \
  --prefix \
  --cert=/etc/kubernetes/pki/etcd/server.crt \
  --key=/etc/kubernetes/pki/etcd/server.key \
  --cacert=/etc/kubernetes/pki/etcd/ca.crt


If encryption is working, you should not see the password CKSrocks123 in plaintext. Instead, you'll see unreadable ciphertext (base64 junk).
✅ If that works, Secrets Encryption at Rest is complete!
Want to now move on to Kyverno, or skip it and go straight to OPA Gatekeeper or Private Registries/ImagePullSecrets?










