# Part 1: Tell Terraform what tools we need.
terraform {
  required_providers {
    github = {
      source  = "hashicorp/github"  # ✅ Correct provider source
      version = "~> 6.0"
    }
  }
}

# Part 2: Configure the GitHub provider
# This will use GitHub token from the environment (e.g., GITHUB_TOKEN set by GitHub Actions)
provider "github" {}

# Part 3: Define our GitHub Label resource
resource "github_issue_label" "my_first_label" {  # ✅ Correct resource type
  repository  = var.repository_name
  name        = "🚀 Deployed by IaC"
  color       = "0075ca"
  description = "This label was created automatically by Terraform."
}

# Part 4: Define the variable to accept repo name
variable "repository_name" {
  type        = string
  description = "The name of the repository where the label will be created."
}
