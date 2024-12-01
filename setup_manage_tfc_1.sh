#!/bin/bash

# Part 1: Initial Setup for Manage-TFC


print_message() {
    echo -e "\n\033[1;34m$1\033[0m"
}


print_message "Cloning the Manage-TFC GitHub repository..."
REPO_NAME="Manage-TFC"
GIT_REPO_URL="https://github.com/arewezaetoime/Manage-TFC.git" # Replace with the actual repo URL

if [[ ! -d "$REPO_NAME" ]]; then
    git clone "$GIT_REPO_URL" "$REPO_NAME"
    if [[ $? -ne 0 ]]; then
        echo "Error: Failed to clone repository. Check the URL and your internet connection."
        exit 1
    fi
    echo "Repository cloned successfully."
else
    echo "Repository already exists. Skipping clone step."
fi

cd "$REPO_NAME" || exit


print_message "Checking for Terraform CLI installation..."
if ! command -v terraform &> /dev/null; then
    echo "Terraform CLI is not installed. Please install it from https://www.terraform.io/downloads."
    exit 1
fi
echo "Terraform CLI is installed."


print_message "Setting up variable configuration..."
if [[ ! -f "terraform.tfvars" ]]; then
    if [[ -f "terraform.tfvars.example" ]]; then
        cp terraform.tfvars.example terraform.tfvars
        echo "Copied terraform.tfvars.example to terraform.tfvars."
        echo -e "\n\033[1;33mACTION REQUIRED: Please edit 'terraform.tfvars' to provide the necessary variable values before proceeding to Part 2.\033[0m"
    else
        echo "Error: terraform.tfvars.example file not found."
        exit 1
    fi
else
    echo "terraform.tfvars already exists. Skipping this step."
fi

# Completion message
print_message "Part 1 complete. Edit 'terraform.tfvars' and then run Part 2 to continue."
