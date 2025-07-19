# 🚀 My First Terraform GitHub Automation

This project shows how to manage GitHub resources (like issue labels) using **Infrastructure as Code (Terraform)** — right inside GitHub Actions!

---

## 🧱 What It Does

When you push code to `main`, the workflow will:

- Automatically create a **GitHub issue label** in your repo via Terraform
- Showcase GitHub + Terraform Integration (clean and manageable IaC!)

---

## 🔐 Setup (One-Time)

You need a **GitHub Personal Access Token (PAT)** to let Terraform authenticate and create resources:

### 🛠️ Step 1: Generate a PAT
1. Go to [https://github.com/settings/tokens](https://github.com/settings/tokens)
2. Click **"Generate new token (classic)"**
3. Select the following scopes:
   - ✅ `repo` (full access to repositories)
4. Click **Generate token**
5. Copy the token (you won't be able to see it again!)

---

### 📝 Step 2: Add the PAT to Your Repository Secrets

1. Go to your repo → **Settings** → **Secrets and variables** → **Actions**
2. Click **"New repository secret"**
3. Set:
   - 🔑 **Name:** `GH_PAT`
   - 🔐 **Value:** _Paste your personal access token_
4. Save 🔒

---

### 🚀 Step 3: Trigger the Workflow

Push a commit to `main`, or go to the **Actions tab** and run **Terraform IaC Workflow** manually.

✅ This will create a label in your GitHub repo called:  
💬 _"🚀 Deployed by IaC"_

---

## ✅ Success Message Example

If everything works, your GitHub actions log will show a successful `terraform apply`, and the label will appear under:

- **Repo → Issues → Labels**

---

## 🙋‍♀️ Want to Learn More?

- [Terraform GitHub Provider Docs](https://registry.terraform.io/providers/hashicorp/github/latest/docs)
- [Creating GitHub PATs](https://docs.github.com/en/github/authenticating-to-github/creating-a-personal-access-token)

---

Happy automating! 🎉
