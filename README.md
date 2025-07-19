# 🌍 GitHub Infrastructure as Code with Terraform

![Terraform Workflow](https://github.com/WheelFate/my-first-iac-project/actions/workflows/terraform.yml/badge.svg)

## 📄 License

This project is licensed under the [MIT License](LICENSE).

Welcome, friend! 👋  
This repo is designed to help **complete beginners** learn how to automate GitHub tasks using **Terraform + GitHub Actions**, full **Infrastructure-as-Code (IaC)** style.

With just one click, you'll automatically create a **label** in your GitHub repo — using **only code**!

---

## 🧠 What Is Terraform?

Terraform is an open-source tool from [HashiCorp](https://www.hashicorp.com/) that lets you:

> **Describe infrastructure in code** (called "Infrastructure as Code" or IaC)  
> And then **build it automatically** with a single command or action.

Examples of what Terraform can automate:
- 🏗 Cloud services (EC2, GCP, Azure)
- 💻 GitHub resources (labels, repos, branch rules!)
- 📅 DNS, monitoring, databases…

You're only writing code — Terraform does the heavy lifting. 💪

---

## 🚀 What Does This Project Do?

Using Terraform & GitHub Actions, you will:
- ⚙️ Define a **GitHub issue label** inside a config file (`main.tf`)
- ▶️ Run a GitHub Action manually (just a button press)
- 🏷️ Automatically create a label in your repo

No clicking around GitHub UI, no mistakes, just one source of truth: **code**.

---

## 📁 What’s Inside This Project?

| File / Folder | Purpose |
|---------------|---------|
| `main.tf` | The Terraform file: defines what label to create |
| `.github/workflows/terraform.yml` | The automation: runs Terraform in the cloud using GitHub Actions |
| `README.md` | This document (how to use everything!) |

---

## 🧾 Step-by-Step: Setup & Run

### ✅ 1. Fork This Repo (or Clone It)

Hit the **Fork** button so you have your own copy.  
Or clone it to your computer.

---

### ✅ 2. Create a GitHub Personal Access Token (PAT)

Terraform needs a token to **authenticate** and talk to your GitHub account.

1. Go to 👉 [GitHub Token Settings](https://github.com/settings/tokens/new)
2. Choose **"Classic token"** or **"Fine-grained" token**
3. ✅ Add this permission:
   - `repo` (full access to your repo)
4. Generate token and **copy it** (save it! You won't see it again)

---

### ✅ 3. Add Your Token as a Secret in Your Repo

1. Go to your repo → **Settings** → **Secrets and variables** → **Actions**
2. Click **"New repository secret"**
3. Add:
   - **Name:** `GH_PAT`
   - **Value:** *Paste your token here*
4. Save

✅ You've now securely stored your PAT!

---

### ✅ 4. Run the Workflow Manually

1. Go to the **Actions** tab of your repo
2. Click **"Terraform IaC Workflow"**
3. Hit the **"Run workflow"** button
4. Wait ~30 seconds...

🎉 Done! You’ve just applied Infrastructure as Code on GitHub itself!

---

## 🔍 Terraform Code Line-by-Line (`main.tf`)

```hcl
terraform {
  required_providers {
    github = {
      source  = "hashicorp/github"   # ✅ Tells Terraform to use official GitHub plugin
      version = "~> 6.0"             # ✅ Compatible with v6.x (latest major version)
    }
  }
}
```

ℹ️ This sets up Terraform to use HashiCorp's GitHub plugin so we can manage GitHub through code.

```hcl
provider "github" {}
```

- This is the configuration block for the provider
- It’ll use the `GITHUB_TOKEN` (your PAT) set in the workflow

```hcl
resource "github_issue_label" "my_first_label" {
  repository  = var.repository_name        # ✅ Which repo to use (set automatically)
  name        = "🚀 Deployed by IaC"       # ✅ Label name
  color       = "0075ca"                   # ✅ Pretty blue
  description = "This label was created automatically by Terraform."
}
```

This is the actual infrastructure!

It says:  
> “Hey Terraform, please create a label in this GitHub repo named `🚀 Deployed by IaC`, make it blue, and say that IaC made it.”

```hcl
variable "repository_name" {
  type        = string
  description = "The name of the repository where the label will be created."
}
```

✨ This variable allows us to **dynamically** pass the target repo, using GitHub's `${{ github.repository }}` value in the workflow.

---

## ⚙ GitHub Actions File (`.github/workflows/terraform.yml`)

Your **terraform.yml** workflow automates Terraform using **GitHub Actions** — GitHub’s built-in CI/CD runner.

### ✅ Key Sections

```yaml
name: "Terraform IaC Workflow"

on:
  workflow_dispatch:

env:
  TF_VAR_repository_name: ${{ github.repository }}

permissions:
  contents: write
  pull-requests: write

jobs:
  terraform:
    runs-on: ubuntu-latest
    
    steps:
      - name: Checkout
        uses: actions/checkout@v4

      - name: Setup Terraform
        uses: hashicorp/setup-terraform@v3

      - name: Terraform Init
        run: terraform init

      - name: Terraform Plan
        run: terraform plan
        env:
          GITHUB_TOKEN: ${{ secrets.GH_PAT }}

      - name: Terraform Apply
        run: terraform apply -auto-approve
        env:
          GITHUB_TOKEN: ${{ secrets.GH_PAT }}
```

### 🔍 What Each Step Does

- `workflow_dispatch:` — Makes the workflow **manual only**
- `TF_VAR_repository_name:` — Sends your repo name into Terraform as a variable
- `GITHUB_TOKEN:` — Pulls your Personal Access Token from repo secrets so Terraform can connect

---

## 🏁 What Happens When You Run It?

1. GitHub loads your action
2. Terraform logs in using your token
3. Terraform creates a label:  
   **`🚀 Deployed by IaC`**  
   in the **Issues → Labels** tab of your repo

✅ This proves IaC works — treating GitHub like infrastructure!

---

## 🧠 Next Steps to Try

Try editing your `main.tf` and running the workflow again!

🎨 Change label color  
🔥 Add a second label  
🔁 Delete and reapply with changes

Example:

```hcl
name = "🔥 Warmup Ready"
color = "ff5500"
description = "Fired up via IaC!"
```

---

## 📚 Resources for Learning More

- [Terraform GitHub Provider Docs](https://registry.terraform.io/providers/hashicorp/github/latest/docs)
- [What is IaC? (Red Hat)](https://www.redhat.com/en/topics/automation/what-is-infrastructure-as-code-iac)
- [Terraform Tutorials (HashiCorp)](https://developer.hashicorp.com/terraform/tutorials)
- [GitHub Actions Guide](https://docs.github.com/en/actions)

---

## 🧡 Why Use This?

| Benefit | Why It Rocks |
|--------|--------------|
| ✅ Automation | No more clicking and forgetting settings |
| ✅ Repeatable Setup | Reuse across 100s of repos |
| ✅ Beginner-Friendly | Simple and safe first step into DevOps and IaC |
| ✅ Secure | Uses secret tokens, not in code |

---

## 💬 Questions or Feedback?

- Found a mistake? ❗ Open an issue
- Want to try more advanced IaC? 🏗 Let's go!
- Pull requests are welcome too! ✅

---

Happy Terraforming! 🏗️🚀
