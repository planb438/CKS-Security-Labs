🐳 Scenario 7: Private Docker Registry + imagePullSecrets
📘 Real-World Context
In production, images are often stored in private registries like Docker Hub, Harbor, or ECR. Kubernetes needs an imagePullSecret to authenticate and pull from them.

In this lab, you’ll:

Push a dummy image to Docker Hub (or skip if already done)

Create a secret using kubectl create secret docker-registry

Deploy a pod that pulls the image using that secret

🎯 Objectives
Login to Docker Hub (or any registry)

Create imagePullSecret

Deploy a pod that uses it

Validate image is pulled successfully

📁 Files
bash
Copy
Edit
cks-labs/
└── 07-private-registry/
    ├── create-secret.sh
    ├── private-pod.yaml
    ├── test-secret.yaml
    └── README.md

---


🧰 1. Login & Build/Push Image (One-Time)

---

```bash
docker login
docker build -t YOUR_DOCKERHUB_USERNAME/cks-demo:1.0 .
docker push YOUR_DOCKERHUB_USERNAME/cks-demo:1.0
You can use busybox or any small image instead.


---


📘 README.md Summary
markdown
Copy
Edit
# 🐳 Private Registry Access with imagePullSecrets

## 🎯 Goal
Pull an image from a private Docker registry using `imagePullSecrets`.

## ✅ Steps
1. Build/push image to private registry
2. Create a secret of type `docker-registry`
3. Attach it in pod spec under `imagePullSecrets`

## 🧪 Test
```bash
kubectl apply -f create-secret.sh
kubectl apply -f private-pod.yaml
kubectl get pods -n private-test
Pod should go to Running. If not, describe it:

bash
Copy
Edit
kubectl describe pod private-puller -n private-test
💡 CKS Tip
You can attach a secret to a ServiceAccount for all pods

Works with DockerHub, Harbor, ECR, GitHub Container Registry, etc.

---

Great observation — you’re using Podman, not Docker, and Podman doesn’t default to Docker Hub unless explicitly configured.

This is another real-world security scenario where container tooling differences affect how credentials and image pulls work — very relevant for CKS.

🛠 Fix: Configure Podman to Use Docker Hub
✅ Step 1: Edit registries.conf
Open or create this file:

bash
Copy
Edit
sudo nano /etc/containers/registries.conf
Add the following under [registries.search]:

toml
Copy
Edit
[registries.search]
registries = ['docker.io']
Save and exit.

✅ Step 2: Login to Docker Hub
Now retry:

bash
Copy
Edit
podman login docker.io
You should see:

makefile
Copy
Edit
Username: your_dockerhub_username
Password:
Login Succeeded!
This will create or update your ~/.docker/config.json with Docker Hub credentials — the same file used by kubectl create secret docker-registry.

✅ Step 3: Create Pull Secret Using Podman Credentials
bash
Copy
Edit
kubectl create secret docker-registry regcred \
  --docker-username=your_dockerhub_username \
  --docker-password='yourpassword' \
  --docker-email=you@example.com \
  -n private-test
💡 CKS Tips
Podman is rootless and security-focused — a good alternative to Docker

In CKS exams, focus is on Kubernetes behavior, not container engine

Always test your imagePullSecrets before using in production

