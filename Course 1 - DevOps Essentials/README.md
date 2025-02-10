**OUTPUT SCREENSHOTS**

Refer the link below for the output of the following script 
https://docs.google.com/document/d/11DZHdAAGgKuQeYa7tJSY8GqN3D7caYvUy_Dlkw-uEeM/edit?usp=sharing

**Tools and Technologies Learnt**

- Linux and Bash scripting
- Networking fundamentals
- DevOps - Git, Web servers and AWS services. 

**Tasks Performed**

**Task 1:**
Task 1: Set Up Necessary Infrastructure
Create IAM Role:

Role Name: YourFirstName_CourseAssignment
Attach Policy: AmazonS3FullAccess
Tag: (EC2, S3Full)
Create Security Group:

Name: SG_YourFirstName
Description: Required for Course Assignment
Open Ports: 80, 443, 22
Tag: WebServer Sec
Launch EC2 Instance:

Region: us-east-1 (North Virginia)
AMI: Ubuntu Server 18.04 LTS (HVM)
Type: t2.micro
VPC: Default VPC
Attach IAM Role: YourFirstName_CourseAssignment
Tag: Name=Web Server
Attach Security Group: SG_YourFirstName

**Task 2:**

Task 2: Apache Logs Automation & S3 Backup
Update System & Install Apache2 (if not installed).
Ensure Apache2 is Running & Enabled at startup.
Archive Apache Logs (.log files) from /var/log/apache2/ to /tmp/ with format:
<YourName>-httpd-logs-<timestamp>.tar
Upload Archive to S3 using AWS CLI.
Host Script on GitHub:
Repo: Automation_Project
Branch: Dev → PR → Merge to Main
Tag: Automation-v0.1

**Task 3:**

Task 3: Bookkeeping & Automation
Inventory File (inventory.html):

Check/Create in /var/www/html/.
Append log metadata (Log Type, Timestamp, Archive Type, Size).
Cron Job Setup:

Check/Create cron job in /etc/cron.d/automation.
Schedule daily execution of automation.sh.
GitHub Update:

Commit to Dev → PR → Merge to Main.
Tag: Automation-v0.2.
