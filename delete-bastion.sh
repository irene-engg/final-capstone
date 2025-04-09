#!/bin/bash
set -e

echo "This script will remove only the bastion host resources from your AWS infrastructure"

# Change to terraform-phase1 directory where the bastion is defined
cd ./terraform-phase1

# Initialize Terraform without loading the variables
echo "Initializing Terraform..."
terraform init \
    -backend-config="bucket=capstonebucketcloud2025" \
    -backend-config="key=production/terraform.tfstate" \
    -backend-config="region=ca-central-1"

# First identify the bastion resources in the state
echo "Identifying bastion resources in the state..."
terraform state list | grep -i "bastion" > /tmp/bastion_resources.txt

if [ -s /tmp/bastion_resources.txt ]; then
  echo "Found the following bastion resources:"
  cat /tmp/bastion_resources.txt
  
  # Remove each bastion resource from the state
  echo "Removing bastion resources from the Terraform state..."
  cat /tmp/bastion_resources.txt | while read resource; do
    echo "Removing $resource from state..."
    terraform state rm "$resource"
  done
  
  echo "Bastion resources have been removed from the Terraform state"
  echo "Now using AWS CLI to terminate the bastion instance directly..."
  
  # Get the instance ID using AWS CLI
  INSTANCE_ID=$(aws ec2 describe-instances --filters "Name=tag:Name,Values=bastion-host" --query "Reservations[*].Instances[*].InstanceId" --output text)
  
  if [ -n "$INSTANCE_ID" ]; then
    echo "Found bastion instance: $INSTANCE_ID"
    
    # Terminate the instance
    aws ec2 terminate-instances --instance-ids $INSTANCE_ID
    echo "Bastion instance termination initiated"
    
    # Wait for termination to complete
    echo "Waiting for instance to terminate..."
    aws ec2 wait instance-terminated --instance-ids $INSTANCE_ID
    echo "Bastion instance terminated successfully"
    
    # Delete the bastion security group
    SG_ID=$(aws ec2 describe-security-groups --filters "Name=group-name,Values=bastion-sg" --query "SecurityGroups[*].GroupId" --output text)
    if [ -n "$SG_ID" ]; then
      echo "Found bastion security group: $SG_ID"
      aws ec2 delete-security-group --group-id $SG_ID
      echo "Bastion security group deleted"
    fi
  else
    echo "No bastion instance found with tag 'bastion-host'"
  fi
else
  echo "No bastion resources found in the Terraform state"
fi

echo "Bastion resources have been removed. You can now proceed with the regular destroy process." 