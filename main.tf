terraform {
  required_providers {
    github = {
      source  = "hashicorp/github"
      version = "~> 6.0"
    }
  }
}

provider "github" {}

resource "github_issue_label" "my_first_label" {
  repository  = var.repository_name
  name        = "🚀 Deployed by IaC"
  color       = "0075ca"
  description = "This label was created automatically by Terraform."
}

variable "repository_name" {
  type        = string
  description = "The name of the repository where the label will be created."
}
