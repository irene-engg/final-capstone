#!/bin/bash
set -e

echo "Beginning destruction of Phase 2 resources..."

# Change to terraform-phase2 directory
cd ./terraform-phase2

# Initialize Terraform
echo "Initializing Terraform..."
terraform init \
    -backend-config="bucket=capstonebucketcloud2025" \
    -backend-config="key=production/phase2/terraform.tfstate" \
    -backend-config="region=ca-central-1"

# Fix the variable type mismatch in terraform.tfvars
echo "Fixing variable type mismatch in terraform.tfvars..."
if [ -f terraform.tfvars ]; then
  # Backup the original file
  cp terraform.tfvars terraform.tfvars.bak
  
  # Replace bastion_allowed_ssh_cidr line with string value
  sed -i 's/bastion_allowed_ssh_cidr = \[\(.*\)\]/bastion_allowed_ssh_cidr = \1/' terraform.tfvars || true
  
  # On macOS, sed works differently, so try this if the above fails
  sed -i '' 's/bastion_allowed_ssh_cidr = \[\(.*\)\]/bastion_allowed_ssh_cidr = \1/' terraform.tfvars 2>/dev/null || true
  
  echo "Fixed terraform.tfvars file."
fi

# First, let's try to remove the ECS services which depend on the target groups
echo "Creating a temporary plan to destroy ECS services first..."
cat > destroy_ecs.tf <<EOF
resource "null_resource" "destroy_first" {
  # This is just a placeholder to make Terraform happy
  provisioner "local-exec" {
    command = "echo 'Preparing to destroy ECS services...'"
  }
}

# Tell Terraform to destroy the ECS services first
resource "aws_ecs_service" "frontend_service" {
  count = 0
}

resource "aws_ecs_service" "backend_service" {
  count = 0
}

# Make sure any listeners are removed
resource "aws_lb_listener" "frontend" {
  count = 0
}

resource "aws_lb_listener" "backend" {
  count = 0
}
EOF

echo "Applying changes to remove ECS services and listeners first..."
terraform apply -auto-approve

# Remove the temporary file
rm destroy_ecs.tf

# Now attempt the full destroy
echo "Proceeding with full destruction of Phase 2 resources..."
terraform destroy -auto-approve || {
  echo "First destroy attempt failed, trying targeted approach..."
  
  # If full destroy fails, try destroying resources in specific order
  terraform destroy -target=module.fargate.aws_ecs_service.frontend_service -auto-approve
  terraform destroy -target=module.fargate.aws_ecs_service.backend_service -auto-approve
  terraform destroy -target=module.frontendalb.aws_lb_listener.frontend -auto-approve
  terraform destroy -target=module.backendalb.aws_lb_listener.backend -auto-approve
  
  # Then try a full destroy again
  echo "Trying full destroy again..."
  terraform destroy -auto-approve
}

# Restore the original terraform.tfvars if we backed it up
if [ -f terraform.tfvars.bak ]; then
  mv terraform.tfvars.bak terraform.tfvars
fi

echo "Phase 2 resources destruction completed successfully!" 