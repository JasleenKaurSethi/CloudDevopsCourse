#!/bin/bash

# Set AWS Region
AWS_REGION="us-east-1"

# IAM Role Variables
IAM_ROLE_NAME="EC2S3AccessRole"
IAM_POLICY_NAME="EC2S3Policy"
INSTANCE_PROFILE_NAME="EC2S3InstanceProfile"

# Security Group Variables
SECURITY_GROUP_NAME="EC2SecurityGroup"
SECURITY_GROUP_DESCRIPTION="Allow SSH and HTTP access"
VPC_ID=$(aws ec2 describe-vpcs --query "Vpcs[0].VpcId" --output text --region $AWS_REGION)

# EC2 Instance Variables
EC2_INSTANCE_NAME="MyEC2Instance"
AMI_ID="ami-0c55b159cbfafe1f0"  # Amazon Linux 2 AMI ID (Check for your region)
INSTANCE_TYPE="t2.micro"
KEY_PAIR_NAME="my-key-pair"  # Change this to your key pair name

# S3 Bucket Variables
S3_BUCKET_NAME="my-unique-s3-bucket-$(date +%s)"

# Create IAM Role for EC2 to access S3
echo "Creating IAM Role: $IAM_ROLE_NAME"
aws iam create-role --role-name $IAM_ROLE_NAME --assume-role-policy-document '{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Principal": { "Service": "ec2.amazonaws.com" },
            "Action": "sts:AssumeRole"
        }
    ]
}' --region $AWS_REGION

# Attach S3 access policy to IAM Role
echo "Attaching policy to IAM Role"
aws iam put-role-policy --role-name $IAM_ROLE_NAME --policy-name $IAM_POLICY_NAME --policy-document '{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": ["s3:*"],
            "Resource": ["*"]
        }
    ]
}' --region $AWS_REGION

# Create an Instance Profile and attach the IAM role
aws iam create-instance-profile --instance-profile-name $INSTANCE_PROFILE_NAME --region $AWS_REGION
aws iam add-role-to-instance-profile --instance-profile-name $INSTANCE_PROFILE_NAME --role-name $IAM_ROLE_NAME --region $AWS_REGION

# Create Security Group
echo "Creating Security Group: $SECURITY_GROUP_NAME"
SECURITY_GROUP_ID=$(aws ec2 create-security-group --group-name $SECURITY_GROUP_NAME --description "$SECURITY_GROUP_DESCRIPTION" --vpc-id $VPC_ID --query "GroupId" --output text --region $AWS_REGION)

# Add Inbound Rules (Allow SSH and HTTP)
aws ec2 authorize-security-group-ingress --group-id $SECURITY_GROUP_ID --protocol tcp --port 22 --cidr 0.0.0.0/0 --region $AWS_REGION
aws ec2 authorize-security-group-ingress --group-id $SECURITY_GROUP_ID --protocol tcp --port 80 --cidr 0.0.0.0/0 --region $AWS_REGION

# Launch EC2 Instance
echo "Launching EC2 Instance: $EC2_INSTANCE_NAME"
INSTANCE_ID=$(aws ec2 run-instances --image-id $AMI_ID --instance-type $INSTANCE_TYPE --key-name $KEY_PAIR_NAME --security-group-ids $SECURITY_GROUP_ID --iam-instance-profile Name=$INSTANCE_PROFILE_NAME --query "Instances[0].InstanceId" --output text --region $AWS_REGION)

# Tag EC2 Instance
aws ec2 create-tags --resources $INSTANCE_ID --tags Key=Name,Value=$EC2_INSTANCE_NAME --region $AWS_REGION

# Create an S3 Bucket
echo "Creating S3 Bucket: $S3_BUCKET_NAME"
aws s3api create-bucket --bucket $S3_BUCKET_NAME --region $AWS_REGION --create-bucket-configuration LocationConstraint=$AWS_REGION

echo "Script execution completed."
