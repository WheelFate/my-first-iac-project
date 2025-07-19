# Part 1: Tell Terraform what tools we need.
# We are telling it we need the official "github" tool.
terraform {
  required_providers {
    github = {
      source  = "integrations/github"
      version = "~> 6.0"
    }
  }
}

# Part 2: Configure the tool.
# We leave this empty. When running in GitHub Actions, it will
# automatically and securely authenticate for us.
provider "github" {}

# Part 3: Define our resource blueprint.
# This is the "Infrastructure as Code" part. We are describing
# a GitHub Label that we want to exist.
resource github_repository_label "my_first_label" {
  # This variable gets the repo name automatically from GitHub Actions.
  repository = var.repository_name

  # These are the settings for our new label.
  name        = "🚀 Deployed by IaC"
  color       = "0075ca" # A nice blue color
  description = "This label was created automatically by Terraform."
}

# Part 4: Define an input variable.
# This sets up a variable that our automation will use to pass in
# the repository name to our Terraform code.
variable "repository_name" {
  type        = string
  description = "The name of the repository where the label will be created."
}
