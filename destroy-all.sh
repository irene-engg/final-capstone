#!/bin/bash
set -e

echo "==================================================="
echo "  TERRAFORM INFRASTRUCTURE DESTRUCTION SCRIPT"
echo "==================================================="
echo "This script will destroy ALL your AWS infrastructure"
echo "for both Phase 2 and Phase 1."
echo ""
echo "Are you sure you want to proceed? Type 'destroy' to confirm:"
read confirmation

if [ "$confirmation" != "destroy" ]; then
  echo "Destruction cancelled."
  exit 1
fi

echo "Starting destruction process..."

# Make the scripts executable
chmod +x destroy-phase2.sh
chmod +x destroy-phase1.sh

# First destroy Phase 2
echo "==================================================="
echo "STEP 1: DESTROYING PHASE 2 RESOURCES"
echo "==================================================="
./destroy-phase2.sh

# Then destroy Phase 1
echo "==================================================="
echo "STEP 2: DESTROYING PHASE 1 RESOURCES"
echo "==================================================="
./destroy-phase1.sh

echo "==================================================="
echo "DESTRUCTION COMPLETE"
echo "==================================================="
echo "All infrastructure has been destroyed successfully."
echo ""
echo "To clean up S3 state files (optional):"
echo "aws s3 rm s3://capstonebucketcloud2025/production/terraform.tfstate"
echo "aws s3 rm s3://capstonebucketcloud2025/production/phase2/terraform.tfstate" 