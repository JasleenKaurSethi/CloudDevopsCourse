#!/bin/bash

# Variables
IAM_ROLE_NAME="jasleen_CourseAssignment"
SECURITY_GROUP_NAME="SG_jasleenxx"
EC2_INSTANCE_NAME="CourseAssignmentInstance"
REGION="us-east-1"
AMI_ID="ami-0c55b159cbfafe1f0"  # Ubuntu Server 20.04 LTS AMI for us-east-1
INSTANCE_TYPE="t2.micro"
VPC_ID=$(aws ec2 describe-vpcs --query "Vpcs[0].VpcId" --region $REGION --output text)

# Create IAM Role
aws iam create-role --role-name $IAM_ROLE_NAME \
  --assume-role-policy-document '{"Version": "2012-10-17", "Statement": [{"Effect": "Allow", "Principal": {"Service": "ec2.amazonaws.com"}, "Action": "sts:AssumeRole"}]}'

# Attach Policy to IAM Role
aws iam attach-role-policy --role-name $IAM_ROLE_NAME --policy-arn arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryFullAccess

# Create Instance Profile and Attach IAM Role
aws iam create-instance-profile --instance-profile-name $IAM_ROLE_NAME
aws iam add-role-to-instance-profile --instance-profile-name $IAM_ROLE_NAME --role-name $IAM_ROLE_NAME

# Create Security Group
SECURITY_GROUP_ID=$(aws ec2 create-security-group --group-name $SECURITY_GROUP_NAME \
  --description "Required for Course Assignment" --vpc-id $VPC_ID --region $REGION --query "GroupId" --output text)

# Add Inbound Rules (Ports 22, 80, 443)
aws ec2 authorize-security-group-ingress --group-id $SECURITY_GROUP_ID --protocol tcp --port 22 --cidr 0.0.0.0/0 --region $REGION
aws ec2 authorize-security-group-ingress --group-id $SECURITY_GROUP_ID --protocol tcp --port 80 --cidr 0.0.0.0/0 --region $REGION
aws ec2 authorize-security-group-ingress --group-id $SECURITY_GROUP_ID --protocol tcp --port 443 --cidr 0.0.0.0/0 --region $REGION

# Launch EC2 Instance
INSTANCE_ID=$(aws ec2 run-instances --image-id $AMI_ID --instance-type $INSTANCE_TYPE \
  --iam-instance-profile Name=$IAM_ROLE_NAME --security-group-ids $SECURITY_GROUP_ID \
  --region $REGION --query "Instances[0].InstanceId" --output text)

# Tag EC2 Instance
aws ec2 create-tags --resources $INSTANCE_ID --tags Key=Name,Value=$EC2_INSTANCE_NAME --region $REGION
