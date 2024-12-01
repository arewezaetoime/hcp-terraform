# hcp-terraform

Settings/ Developer /settings /hcp-terraform-oauth
Settings Developer settings hcp-terraform-oauth


* tfe_token = token - The token used to authenticate with HCP Terraform or Terraform Enterprise. See Authentication above for more information.

Generating the github oauth token:
Go to setting / Right circle with the picture of your profile
Go to settings
Developer settings
Personal access tokens
Fine-grained tokens
Create a new token and tweak the settings and the scope of the token
Select the permissions of the token

For your convenience I created a bash script that automates all the steps of creating the resources and everything
Note: if the script doesn't run successfully please manually make the script executable with this command:
chmod +x setup_manage_tfc_1.sh setup_manage_tfc_2.sh

we are creating oauth token when connecting hcp to a git repository

Resolving disabled input in automation environment
terraform init -input=true



<!-- 
First initialization should look like this:
terraform plan -target=tfe_workspace.parent-vcs -target=tfe_workspace.parent
terraform apply -target=tfe_workspace.parent-vcs -target=tfe_workspace.parent -->
