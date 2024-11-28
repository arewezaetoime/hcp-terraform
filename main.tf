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

resource "tfe_workspace" "vcs-parent" {
  name                 = "vcs-ws"
  organization         = tfe_organization.the-funky-terraformers.name
  project_id           = tfe_project.interview-task-project.id
  vcs_repo {
    branch             = "main"
    identifier         = "the-funky-terraformers/hcp-terraform-vcs-repo"
    oauth_token_id     = tfe_oauth_client.github_oauth_client.oauth_token_id
  }
}

resource "tfe_oauth_client" "github_oauth_client" {
  organization      = var.organization_name
  api_url           = "https://api.github.com"
  http_url          = "https://github.com"
  oauth_token = var.oauth_token_id
  service_provider  = "github"
}

resource "tfe_workspace" "parent" {
  count = 3
  name                 = "parent-${count.index + 1}"
  organization         = tfe_organization.the-funky-terraformers.name
  project_id = tfe_project.interview-task-project.id
}
