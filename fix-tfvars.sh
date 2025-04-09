#!/bin/bash
set -e

echo "Fixing terraform.tfvars files in both Phase 1 and Phase 2..."

# Fix Phase 2 terraform.tfvars
echo "Checking Phase 2 terraform.tfvars..."
if [ -f terraform-phase2/terraform.tfvars ]; then
  # Backup the original file
  cp terraform-phase2/terraform.tfvars terraform-phase2/terraform.tfvars.bak
  
  # Replace bastion_allowed_ssh_cidr line with string value
  sed -i 's/bastion_allowed_ssh_cidr = \[\(.*\)\]/bastion_allowed_ssh_cidr = \1/' terraform-phase2/terraform.tfvars || true
  
  # On macOS, sed works differently, so try this if the above fails
  sed -i '' 's/bastion_allowed_ssh_cidr = \[\(.*\)\]/bastion_allowed_ssh_cidr = \1/' terraform-phase2/terraform.tfvars 2>/dev/null || true
  
  echo "Fixed terraform-phase2/terraform.tfvars file."
fi

# Fix Phase 1 terraform.tfvars
echo "Checking Phase 1 terraform.tfvars..."
if [ -f terraform-phase1/terraform.tfvars ]; then
  # Backup the original file
  cp terraform-phase1/terraform.tfvars terraform-phase1/terraform.tfvars.bak
  
  # Replace bastion_allowed_ssh_cidr line with string value
  sed -i 's/bastion_allowed_ssh_cidr = \[\(.*\)\]/bastion_allowed_ssh_cidr = \1/' terraform-phase1/terraform.tfvars || true
  
  # On macOS, sed works differently, so try this if the above fails
  sed -i '' 's/bastion_allowed_ssh_cidr = \[\(.*\)\]/bastion_allowed_ssh_cidr = \1/' terraform-phase1/terraform.tfvars 2>/dev/null || true
  
  echo "Fixed terraform-phase1/terraform.tfvars file."
fi

echo "All terraform.tfvars files have been fixed!"
echo "You can now run the destroy scripts or your terraform commands." 