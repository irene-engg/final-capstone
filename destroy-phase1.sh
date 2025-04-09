#!/bin/bash
set -e

echo "Beginning destruction of Phase 1 resources..."
echo "WARNING: Make sure Phase 2 resources have been destroyed first!"
echo "Press Ctrl+C now to cancel if you haven't destroyed Phase 2 yet."
echo "Continuing in 10 seconds..."
sleep 10

# Change to terraform-phase1 directory
cd ./terraform-phase1

# Initialize Terraform
echo "Initializing Terraform..."
terraform init \
    -backend-config="bucket=capstonebucketcloud2025" \
    -backend-config="key=production/terraform.tfstate" \
    -backend-config="region=ca-central-1"

# Try to destroy resources in specific order
echo "Attempting targeted destruction..."

# First, destroy the listeners that might be causing issues with target groups
terraform state list | grep -i listener > /tmp/listeners.txt
if [ -s /tmp/listeners.txt ]; then
  echo "Destroying listeners first..."
  cat /tmp/listeners.txt | while read listener; do
    echo "Destroying $listener..."
    terraform destroy -target=$listener -auto-approve
  done
fi

# Now attempt the full destroy
echo "Proceeding with full destruction of Phase 1 resources..."
terraform destroy -auto-approve || {
  echo "First destroy attempt failed, trying targeted approach..."
  
  # If destroy fails, try targeted destruction of components in appropriate order
  echo "Targeted destruction of critical resources..."
  
  # Try to destroy ALBs first
  terraform state list | grep -i "aws_lb" > /tmp/albs.txt
  if [ -s /tmp/albs.txt ]; then
    cat /tmp/albs.txt | while read alb; do
      echo "Destroying $alb..."
      terraform destroy -target=$alb -auto-approve || true
    done
  fi
  
  # Then try target groups
  terraform state list | grep -i "target_group" > /tmp/tgs.txt
  if [ -s /tmp/tgs.txt ]; then
    cat /tmp/tgs.txt | while read tg; do
      echo "Destroying $tg..."
      terraform destroy -target=$tg -auto-approve || true
    done
  fi
  
  # Try a full destroy again
  echo "Trying full destroy again..."
  terraform destroy -auto-approve
}

echo "Phase 1 resources destruction completed successfully!" 