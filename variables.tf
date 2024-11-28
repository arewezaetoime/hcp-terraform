variable "tfe_token"  {
  description = "Terraform Cloud API token"
  type        = string
  sensitive   = true
}

variable "oauth_token_id" {
  description = "OAuth token ID for connecting to VCS"
  type        = string
}

variable "organization_name" {
  description = "Organization name"
  type = string
  sensitive = false
}

# variable "github_organization_name" {
#   description = "Organization name"
#   type = string
#   sensitive = false
# }