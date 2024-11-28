# terraform {
#   required_providers {
#     tfe = {
#       version = "~> 0.60.1"
#     }
#   }
# }

provider "tfe" {
  hostname = "app.terraform.io"
  token    = var.tfe_token
  organization = "the-funky-terraformers"
}

resource "tfe_organization" "the-funky-terraformers" {
  name  = var.organization_name
  email = "xx@xx.com"
}

resource "tfe_project" "interview-task-project" {
  organization = tfe_organization.the-funky-terraformers.name
  name = "interview-task-project"
}

resource "tfe_oauth_client" "github_oauth_client" {
  organization      = var.github_organization_name
  api_url           = "https://api.github.com"
  http_url          = "https://github.com/arewezaetoime/hcp-terraform"
  service_provider  = "github"
  oauth_token_id    = var.oauth_token_id # Pass the token as a variable
}

resource "tfe_workspace" "vcs-parent" {
  name                 = "vcs-ws"
  organization         = tfe_organization.the-funky-terraformers.name
  queue_all_runs       = false
  vcs_repo {
    branch             = "main"
    identifier         = "the-funky-terraformers/vcs-repository"
    oauth_token_id     = var.oauth_token_id
  }
}

resource "tfe_workspace" "parent" {
  count = 3
  name                 = "parent-${count.index + 1}"
  organization         = tfe_organization.the-funky-terraformers.name
  project_id = tfe_project.interview-task-project.id
}
