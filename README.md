# hcp-terraform
WTF I can't believe how dumb I can be.... just don't paste the keys to the tfvars file.... leave the values empty so the person cloning the repo will insert their keys OMG and I was trying to find many different and complicated ways to preserve and load them from the cloud or elsewhere

Settings/ Developer /settings /hcp-terraform-oauth
Settings Developer settings hcp-terraform-oauth

Generating the github oauth token:
Go to setting / Right circle with the picture of your profile
Go to settings
Developer settings
Personal access tokens
Fine-grained tokens
Create a new token and tweak the settings and the scope of the token
Select the permissions of the token



we are creating oauth token when connecting hcp to a git repository

Resolving disabled input in automation environment
terraform init -input=true




First initialization should look like this:
terraform plan -target=tfe_workspace.parent-vcs -target=tfe_workspace.parent
terraform apply -target=tfe_workspace.parent-vcs -target=tfe_workspace.parent
