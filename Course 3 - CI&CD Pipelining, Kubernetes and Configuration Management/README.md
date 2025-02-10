**OUTPUT SCREENSHOTS**

Refer the link below for the output of the following script:
https://drive.google.com/file/d/1l-Q5Q9Rsw-14BkLF_Swu0r7QZvHfe-Cx/view?usp=drive_link

**Tools and Technologies Learnt:**

- Infrastructure automation using Terraform
- Managing access with IAM roles in AWS
- Setting up Application Load Balancer (ALB) in AWS
- Continuous integration with ECR for Docker image storage
- SSH access configuration and ProxyJump usage
- System provisioning and configuration management with Ansible
- Building a CI/CD pipeline using Jenkins

**Tasks Performed:**

*Task 1: Setup Infrastructure using Terraform*
Subtask 1:

Install and configure AWS CLI with full access.
Initialize an S3 bucket in us-east-1 for Terraform state store.
Subtask 2:

Create AWS VPC with 1 IGW, 1 NAT-GW (AZ-a), and 2 public & 2 private subnets (1 in AZ-a and AZ-b).
Set route tables and ensure private subnets route traffic via NAT-GW.
Use /16 CIDR for VPC and /24 CIDRs for subnets.
Subtask 3:

Create Security Groups for Bastion, Private Instances, and Public Web.
Automate self IP retrieval for Bastion SG SSH access.
Subtask 4:

Create EC2 key pair for access.
Launch 3 EC2 instances (Bastion, Jenkins, App) using Ubuntu 20.
Bastion instance should be accessible via SSH; others via Proxyjump

**Task 2**

*Task 2: Setup Config Management with Ansible & CI Pipeline with Jenkins*
Subtask 1:

Install Ansible.
Set up Ansible to manage Jenkins and app hosts.
Write inventory file and install Docker on both hosts using Ansible, ensuring Docker service is started.
Subtask 2:

Create ALB listening on port 80, internet-facing.
Forward /jenkins and /app paths to their respective Target Groups (Jenkins and app hosts on port 8080).
Use security groups from Task 1.
Subtask 3:

Manually install Jenkins on the Jenkins instance via Bastion host.
Access Jenkins through ALB, install plugins, and create an admin user.
Configure Jenkins dashboard path with the /jenkins prefix.
Subtask 4:

Create an ECR repository for the node application Docker image.
Attach IAM role for ECR access to Jenkins and app hosts.
Ensure Jenkins can SSH into the app host and execute commands to pull Docker images.
Subtask Bonus:

Use Terraform to set up ALB and Target Groups.






