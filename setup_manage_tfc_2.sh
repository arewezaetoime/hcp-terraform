#!/bin/bash

# Part 2: Terraform Operations for Manage-TFC

# Function to print formatted messages
print_message() {
    echo -e "\n\033[1;34m$1\033[0m"
}

# Ensure Part 1 has been completed
if [[ ! -f "terraform.tfvars" ]]; then
    echo -e "\n\033[1;31mError: 'terraform.tfvars' not found. Please run Part 1 and edit 'terraform.tfvars' before proceeding.\033[0m"
    exit 1
fi

# Step 1: Initialize Terraform
print_message "Initializing Terraform..."
terraform init
if [[ $? -ne 0 ]]; then
    echo "Error: Terraform initialization failed. Check your configuration and try again."
    exit 1
fi
echo "Terraform initialized successfully."

# Step 2: Validate Terraform configuration
print_message "Validating Terraform configuration..."
terraform validate
if [[ $? -ne 0 ]]; then
    echo "Error: Terraform configuration validation failed. Check your configuration and try again."
    exit 1
fi
echo "Terraform configuration is valid."

# Step 3: Run Terraform Plan
print_message "Running Terraform Plan..."
terraform plan
if [[ $? -ne 0 ]]; then
    echo "Error: Terraform plan failed. Check your configuration and try again."
    exit 1
fi
echo "Terraform plan executed successfully."

# Step 4: Apply Terraform configuration with auto-approval
print_message "Applying Terraform configuration..."
terraform apply -auto-approve
if [[ $? -ne 0 ]]; then
    echo "Error: Terraform apply failed. Check your configuration and try again."
    exit 1
fi
echo "Terraform resources applied successfully."

# Step 5: Final check for Terraform Cloud
print_message "Finalizing setup and verifying Terraform Cloud..."
echo "Your Terraform workspaces and resources should now be available in your HCP Terraform organization."
echo "Log in to https://app.terraform.io to view and manage your setup."

# Final Message
print_message "Setup Complete!"
echo "All steps executed successfully. Thank you for using the Manage-TFC setup script."
