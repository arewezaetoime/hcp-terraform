terraform {
  required_providers {
    tfe = {
      version = "~> 0.60.1"
    }
  }
  backend "remote" {
    hostname     = "app.terraform.io"
    organization = "The-Funky-Terraformers"

    workspaces {
      name = "vcs-parent"
    }
  }
}

provider "tfe" {
  hostname = "app.terraform.io"
  token    = var.tfe_token
  organization = "the-funky-terraformers"
}

# resource "tfe_organization" "the-funky-terraformers" {
#   name  = var.organization_name
#   email = "xx@xx.com"
# }

resource "tfe_project" "interview-task-project" {
  organization = var.organization_name
  name = "interview-task-project"
}

resource "tfe_workspace" "vcs-parent" {
  name                 = "vcs-ws"
  organization         = var.organization_name
  project_id           = tfe_project.interview-task-project.id
  vcs_repo {
    branch             = "main"
    identifier         = "arewezaetoime/hcp-terraform"
    oauth_token_id     = var.oauth_token_id
  }
}

# resource "tfe_oauth_client" "github_oauth_client" {
#   organization      = var.organization_name
#   api_url           = "https://api.github.com"
#   http_url          = "https://github.com"
#   oauth_token = var.oauth_token_id
#   service_provider  = "github"
# }

resource "tfe_workspace" "parent" {
  count = 3
  name                 = "parent-${count.index + 1}"
  organization         = var.organization_name
  project_id = tfe_project.interview-task-project.id
}

resource "tfe_variable_set" "tfe_token_varset" {
  name         = "tfe_token_global_varset"
  description  = "Variable set applied to all workspaces."
  global       = true
  organization = var.organization_name
}

resource "tfe_variable" "tfe_token_terraform" {
  key             = "tfe_token_variable"
  value           = var.tfe_token
  category        = "terraform"
  description     = "Variable set applied to all worksspaces with the tfe token."
  variable_set_id = tfe_variable_set.test.id
}

resource "tfe_variable" "tfe_token_env" {
  key             = "tfe_token_env"
  value           = var.tfe_token
  category        = "env"
  description     = "an environment variable"
  variable_set_id = tfe_variable_set.test.id
}