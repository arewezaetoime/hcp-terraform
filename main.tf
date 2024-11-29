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

resource "tfe_organization" "the-funky-terraformers" {
  name  = "interview-task-project"
  email = "hristoiliev.1994@gmail.com"
}

resource "tfe_project" "interview-task-project" {
  organization = var.organization_name
  name         = "interview-task-project"
}

resource "tfe_oauth_client" "github_oauth_client" {
  name             = var.github_oauth_client_name
  organization     = var.organization_name
  api_url          = "https://api.github.com"
  http_url         = "https://github.com"
  oauth_token      = var.github_oauth_token_id
  service_provider = "github"
  organization_scoped = true
}

output "oauth_token_id" {
  value = tfe_oauth_client.github_oauth_client.oauth_token_id
}

resource "tfe_workspace" "vcs-ws" {
  name         = "vcs-ws"
  organization = var.organization_name
  project_id   = tfe_project.interview-task-project.id
  queue_all_runs = true
  vcs_repo {
    branch         = var.branch_name
    identifier     = "arewezaetoime/hcp-terraform"
    oauth_token_id = tfe_oauth_client.github_oauth_client.oauth_token_id
  }
}

resource "tfe_workspace" "cli_workspaces" {
  count        = 3
  name         = "cli-workspace-${count.index + 1}"
  organization = var.organization_name
  project_id   = tfe_project.interview-task-project.id
}

# data "tfe_variable_set" "sensitive_variables" {
#   name         = "sensitive_variables" 
#   organization = var.organization_name
# }

# resource "tfe_workspace_variable_set" "attach_varset_to_workspaces" {
#   for_each        = toset(tfe_workspace.parent[*].id)
#   variable_set_id = data.tfe_variable_set.sensitive_variables.id
#   workspace_id    = each.value
# }
