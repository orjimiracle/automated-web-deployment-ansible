# 🚀 Mini Finance App Deployment using Ansible

This project demonstrates how to deploy a simple web application using **Ansible**, automate server configuration, and verify deployment.

It is designed as a **beginner-friendly DevOps project** that covers:

* Python virtual environment setup
* SSH configuration
* Ansible inventory and playbooks
* Automated deployment
* Basic verification

---

# 📌 Project Structure

```
mini-finance/
├── Readme.md
├── ansible
│   └── site.yml
├── inventory.ini
└── terraform
    ├── .terraform.lock.hcl
    ├── main.tf
    ├── outputs.tf
    ├── providers.tf
    └── variables.tf
```

---

# ⚙️ Prerequisites

Before starting, ensure you have:

* A Linux machine (Ubuntu recommended)
* Python 3 installed
* SSH access to your server
* A running VM (e.g., Azure)
* Nginx installed on the server

---

# 🧱 Step 1: Create Project Directory

```bash
mkdir -p ~/mini-finance
cd ~/mini-finance
```

---

# 🐍 Step 2: Create Python Virtual Environment

This ensures dependencies are isolated.

```bash
python3 -m venv .venv
```

Activate it:

```bash
source .venv/bin/activate
```

---

# 📦 Step 3: Install Ansible

```bash
pip install ansible
```

Confirm installation:

```bash
ansible --version
```

---

# 🔐 Step 4: Setup SSH Access

Ensure your SSH key exists:

```bash
ls ~/.ssh/
```

If not, generate one:

```bash
ssh-keygen -t rsa -b 2048
```

Ensure your config file has:

```bash
nano ~/.ssh/config
```

Example:

```
Host web1
    HostName <YOUR_SERVER_IP>
    User azureuser
    IdentityFile ~/.ssh/azure_rsa
```

Test connection:

```bash
ssh web1
```

---

# 🌐 Step 5: Configure Inventory File

Create:

```bash
nano inventory.ini
```

Paste:

```
[web]
web1

[all:vars]
ansible_user=azureuser
ansible_ssh_private_key_file=~/.ssh/azure_rsa
ansible_python_interpreter=/usr/bin/python3.10
```

Ensure your `/etc/hosts` contains:

```
<YOUR_SERVER_IP> web1
```

---

# 📜 Step 6: Create Ansible Playbook

Create:

```bash
nano site.yml
```

Paste:

```yaml
- name: Deploy Mini Finance App
  hosts: web
  become: true

  tasks:
    - name: Clone repo
      git:
        repo: https://github.com/pravinmishraaws/mini_finance.git
        dest: /tmp/mini-finance
        version: main
        force: yes
        depth: 1

    - name: Copy files to web root
      copy:
        src: /tmp/mini-finance/
        dest: /var/www/html/
        remote_src: yes

    - name: Set permissions
      file:
        path: /var/www/html/
        owner: www-data
        group: www-data
        recurse: yes
      notify: restart nginx

  handlers:
    - name: restart nginx
      service:
        name: nginx
        state: restarted

- name: Verify Deployment
  hosts: localhost
  gather_facts: false

  tasks:
    - name: Check website
      uri:
        url: "http://{{ item }}"
        status_code: 200
      loop: "{{ groups['web'] }}"
      loop_control:
        label: "{{ item }}"
```

---

# 🚀 Step 7: Run the Playbook

```bash
ansible-playbook -i inventory.ini site.yml
```

---

# ✅ Step 8: Verify Deployment

If successful, Ansible will return **status code 200**.

You can also test manually:

```bash
curl http://web1
```

Or open in browser:

```
http://<YOUR_SERVER_IP>
```

---

# 📂 .gitignore

Create:

```bash
touch .gitignore
```

Paste:

```
# SSH Keys
*.pem
*.key
id_rsa
azure_rsa

# Python Env
.venv/
venv/

# Terraform
.terraform/
*.tfstate
*.tfvars

# Logs
*.log

# OS files
.DS_Store
Thumbs.db

# Sensitive files
.env
```

---

# ⚠️ Important Notes

* Never upload your SSH private key
* Ensure Nginx is installed on your server
* Ensure port 80 is open in your cloud provider
* Ensure correct permissions are set

---

# 🎯 What You Learned

* How to use Ansible for automation
* How to deploy applications remotely
* SSH configuration and secure access
* Infrastructure automation basics

---

# 📌 Author

**Ekeoma Miracle**

* Cybersecurity & DevOps Enthusiast
* Passionate about automation, cloud, and security

---
