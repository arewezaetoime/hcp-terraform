terraform {
  required_providers {
    tfe = {
      version = "~> 0.60.1"
    }
  }
}

provider "tfe" {
  hostname     = var.default_hostname_hcp_terraform
  token        = var.tfe_token
  organization = var.organization_name
}

resource "tfe_project" "interview-task-project" {
  organization = var.organization_name
  name         = var.project_name
}

resource "tfe_oauth_client" "github_oauth_client" {
  name                = var.github_oauth_client_name
  organization        = var.organization_name
  api_url             = "https://api.github.com"
  http_url            = "https://github.com"
  oauth_token         = var.github_oauth_token_id
  service_provider    = "github"
  organization_scoped = true
}

resource "tfe_workspace" "vcs-ws" {
  name           = var.vcs_repository_name
  organization   = var.organization_name
  project_id     = tfe_project.interview-task-project.id
  queue_all_runs = true
  vcs_repo {
    branch         = var.branch_name
    identifier     = var.repo_identifier
    oauth_token_id = tfe_oauth_client.github_oauth_client.oauth_token_id
  }
}

resource "tfe_workspace" "cli_workspaces" {
  count        = 3
  name         = "cli-workspace-${count.index + 1}"
  organization = var.organization_name
  project_id   = tfe_project.interview-task-project.id
}

resource "tfe_variable_set" "varset" {
  name         = "Global Varset"
  description  = "Variable set applied to all workspaces."
  global       = false
  organization = var.organization_name
}

resource "tfe_variable" "org_name_terraform_var" {
  key             = "organization_name_hcp_variable"
  value           = "The-Funky-Terraformers"
  category        = "terraform"
  description     = "This variable is containing the name of out organization"
  variable_set_id = tfe_variable_set.varset.id
}

resource "tfe_variable" "org_name_env_var" {
  key             = "organization_name_hcp_env_var"
  value           = "The-Funky-Terraformers"
  category        = "env"
  description     = "an environment variable"
  variable_set_id = tfe_variable_set.varset.id
}

data "tfe_variable_set" "varset_data" {
  name         = tfe_variable_set.varset.name
  organization = tfe_variable_set.varset.organization
}

resource "tfe_workspace_variable_set" "attach_varset_to_cli_workspaces" {
  for_each = {
    for i, workspace in tfe_workspace.cli_workspaces : workspace.name => workspace.id
  }

  workspace_id    = each.value
  variable_set_id = data.tfe_variable_set.varset_data.id
}
