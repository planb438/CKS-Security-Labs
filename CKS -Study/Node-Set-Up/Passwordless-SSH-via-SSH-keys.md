
✅ Passwordless SSH is set up (via SSH keys)

---

That means:

Your control machine can SSH into the master and worker nodes without being prompted.

You've added your public SSH key to the ~/.ssh/authorized_keys on each node.

---

🔐 To set up passwordless SSH

---

On your control machine:

---

ssh-keygen  # Press Enter through the prompts to generate ~/.ssh/id_rsa

  --
  
ssh-copy-id ubuntu@10.0.0.191   # master

-

ssh-copy-id ubuntu@10.0.0.17    # worker 1

-

ssh-copy-id ubuntu@10.0.0.127   # worker 2

--
---
After this, test:
--

ssh ubuntu@10.0.0.191  # should log in without a password
