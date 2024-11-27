terraform {
  required_providers {
    tfe = {
      version = "~> 0.60.1"
    }
  }
}

provider "tfe" {
  hostname = "app.terraform.io"
  token    = var.tfe_token
  organization = "the-funky-terraformers"
}

resource "tfe_organization" "the-funky-terraformers" {
  name  = "the-funky-terraformers"
  email = "tft@tft.com"
}

resource "tfe_project" "interview-task-project" {
  organization = tfe_organization.name
  name = "interview-task-project"
}

resource "tfe_workspace" "parent" {
  name                 = "parent-ws"
  organization         = tfe_organization.name
  queue_all_runs       = false
  vcs_repo {
    branch             = "main"
    identifier         = "the-funky-terraformers/vcs-repository"
    //oauth_token_id     = tfe_oauth_client.test.oauth_token_id
  }
}
