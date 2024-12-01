#!/bin/bash

# Function to prompt for user input
prompt_user_input() {
    local prompt=$1
    local input
    read -p "$prompt: " input
    echo "$input"
}

# Step 1: Generate a GitHub OAuth Token
echo "Step 1: Generating a GitHub OAuth Token"
echo "You will be redirected to GitHub to create a Fine-grained token."
echo "Please log in to GitHub, navigate to 'Settings > Developer settings > Personal access tokens > Fine-grained tokens', and create a token with the 'repo' scope."

# Open GitHub settings in the browser (requires default browser setup)
if command -v open >/dev/null; then
    open "https://github.com/settings/tokens?type=fine-grained"
elif command -v xdg-open >/dev/null; then
    xdg-open "https://github.com/settings/tokens?type=fine-grained"
else
    echo "Please open the following link in your browser to create the token:"
    echo "https://github.com/settings/tokens?type=fine-grained"
fi

github_oauth_token=$(prompt_user_input "Enter your newly generated GitHub OAuth token")

# Step 2: Verify or Create the GitHub Repository
echo "Step 2: Checking GitHub Repository"
repo_name="Manage-TFC"
repo_url="https://github.com/arewezaetoime/$repo_name.git"

if command -v gh >/dev/null; then
    echo "Checking if the repository $repo_name exists..."
    gh repo view "$repo_name" >/dev/null 2>&1
    if [ $? -ne 0 ]; then
        echo "Repository not found. Creating it now..."
        gh repo create "$repo_name" --public --description "Repository to manage HCP Terraform Cloud resources" --confirm
        echo "Repository $repo_name created successfully."
    else
        echo "Repository $repo_name already exists."
    fi
else
    echo "Please ensure the repository $repo_name exists at $repo_url."
fi

# Step 3: Clone the Repository
echo "Step 3: Cloning the Repository"
git clone "$repo_url"
cd "$repo_name" || exit

# Step 4: Create the terraform.tfvars file
echo "Step 4: Setting up terraform.tfvars"
if [ -f terraform.tfvars.example ]; then
    cp terraform.tfvars.example terraform.tfvars
else
    echo "terraform.tfvars.example file not found. Exiting..."
    exit 1
fi

# Populate the variables in terraform.tfvars
tfe_token=$(prompt_user_input "Enter your Terraform Cloud API token")
organization_name=$(prompt_user_input "Enter your HCP Terraform organization name")

sed -i.bak "s|github_oauth_token_id=.*|github_oauth_token_id=\"$github_oauth_token\"|" terraform.tfvars
sed -i.bak "s|tfe_token=.*|tfe_token=\"$tfe_token\"|" terraform.tfvars
sed -i.bak "s|organization_name=.*|organization_name=\"$organization_name\"|" terraform.tfvars

echo "All variables have been updated in terraform.tfvars."

# Step 5: Final Instructions
echo "Setup complete. Please proceed with the following steps:"
echo "1. Review the terraform.tfvars file to ensure all values are correct."
echo "2. Run 'terraform init' to initialize the working directory."
echo "3. Run 'terraform plan' to create an execution plan."
echo "4. Run 'terraform apply' to apply the changes."

