**OUTPUT SCREENSHOTS**

Refer the link below for the output of the following script:
[https://docs.google.com/document/d/11DZHdAAGgKuQeYa7tJSY8GqN3D7caYvUy_Dlkw-uEeM/edit?usp=sharing](https://drive.google.com/file/d/1cihn_7oX20uq6HADCjRjIUyv1uZwyT7b/view?usp=sharing)

Tools and Technologies Learnt:

- AWS EC2 & Security Groups
- Maven & Docker
- Amazon ECR & AWS CLI
- AWS ECS & Service Discovery
- Application Load Balancer (ALB) & Autoscaling
- MySQL & CloudWatch & SNS
- Apache Benchmark (ab)

**Task 1**

*Task-1: Create an IAM role, a security group, and launch an EC2 instance*

Create an IAM role with AmazonEC2ContainerRegistryFullAccess and attach it to an EC2 instance.
Create a security group with a description and open ports 22, 80, and 443.
Launch an Ubuntu 20.04 t2.micro instance in the default VPC, attach the IAM role and security group, and tag the instance.

**Task 2**

*Task-2: Install Maven and Docker on EC2 & Create Docker Images for UPSTAC Microservices*

Install Maven and Docker-Engine on the EC2 instance.
Clone the UPSTAC application repositories:
UPSTAC-Microservices-Frontend-Code
UPSTAC-Microservices-Backend-CODE
Use Maven to build the jar files for both frontend and backend microservices.
Create Dockerfiles for both microservices (frontend + backend).
Build Docker images using the Docker command for each microservice.

**Task 3**

*Task-3: ECR Repositories and Docker Image Push*

Install AWS CLI on EC2 and configure it.
Create ECR repositories for the UPSTAC microservices (frontend and backend).
Tag the Docker images with the appropriate ECR repository URIs.
Push the Docker images to the corresponding ECR repositories.

**Task 4**

*Task-4: Create Load Balancer and Forwarding Rules*

Create a security group (upstacsg) allowing traffic on required ports for all UPSTAC services.
Create the application load balancer (UPSTAC_ALB) with the upstacsg security group.
Set up a target group for the front-end service and configure load balancer forwarding rules.

**Task 5**

*Task-5: Create ECS Service with Fargate Launch Type*

Create an ECS cluster using Fargate.
Define task definitions for all UPSTAC services, including MySQL, using corresponding ECR repositories and environment variables (from application-prod.properties for backend and environment.js for frontend).
Set task memory to 2GB and CPU to 1 vCPU; enable pseudoTerminal for the front-end.
Define environment variables for the MySQL database.
Create ECS services for the microservices and MySQL database with proper security group.
Enable service discovery with a specified namespace.
Configure autoscaling for the registration service with CPUUtilization target at 5%.
Use dig to verify the registration service accessibility from EC2.

**Task 6**

*Task-6: Set Up Email Notification and Autoscaling*

Create an alarm for CPU Utilization > 5% for the registration service.
Set up an SNS topic for email notifications when the alarm is triggered.
Install Apache Benchmark on EC2 to simulate traffic and trigger autoscaling.
Verify email notification and autoscaling of the registration service.























