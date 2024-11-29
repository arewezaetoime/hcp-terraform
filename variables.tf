variable "tfe_token" {
  description = "Terraform Cloud API token. User/Team/Organization token"
  type        = string
  sensitive   = true
}

variable "oauth_token_id" {
  description = "OAuth token ID for connecting to VCS repository"
  type        = string
  sensitive   = true
}

variable "github_oauth_token_id" {
  description = "Personal access token for connecting to Github VCS repository"
  type = string
  sensitive = true
}

variable "github_oauth_client_name" {
  default = "my-github-oauth-client"
  type = string
}

variable "organization_name" {
  default = "The-Funky-Terraformers"
  description = "HCP Organization name"
  type        = string
  sensitive   = false
}

variable "repo_identifier" {
  default = "arewezaetoime/hcp-terraform"
  description = "The path to the repository taken from the URI"
  type = string
}

variable "default_hostname_hcp_terraform" {
  default = "app.terraform.io"
  description = "The default hostname for HCP Terraform"
  type = string
}

# variable "email_address" {
#   default = "your-email-address@terraform.io"
#   description = "Example email address"
#   type = string
# }

# variable "project_name" {
#   default = "interview-task-project"
#   description = "The name of the project"
#   type = string
# }

# variable "vcs_repository_name" {
#   default = "vcs-ws"
#   description = "The name of the VCS repository in workspace in HCP Terraform"
#   type = string
# }

variable "cli_workspace" {
  default = "cli-workspace-"
  description = "The name of the CLI workspace in HCP Terraform"
  type = string
}

variable "branch_name" {
  default = "main"
  description = "The name of the prefered branch in the remote repository"
  type = string
}

# variable "github_organization_name" {
#   description = "Organization name"
#   type = string
#   sensitive = false
# }
