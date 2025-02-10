**About the Project**

This project is the final project levaraging all the concepts taught in the 6 months Cloud & DevOps course.  In the project, scalable EKS-based Kubernetes infrastructure was created to deploy, manage, and automatically scale a stateless Node.js application and a stateful Redis service with persistent storage.

**Tools and Technologies Learnt**

- AWS & Terraform: AWS CLI, EKS, Terraform, eksctl, ECR, AWS Load Balancer Controller
- Kubernetes & Tools: Kubernetes, Terraform, Ansible, Helm, HPA, Cluster Autoscaler, Kubernetes Metrics Server
- Docker & Redis: Docker, ECR, Redis, StatefulSets
- Monitoring & Scaling: Prometheus, Apache Benchmark (ab)

**Tasks Performed**

**Task 1:**

*Task 1: EKS Cluster Setup with Custom VPC*
Subtask 1:

Install and configure AWS CLI with full access.
Initialize an S3 bucket in us-east-1 for Terraform backend.
Subtask 2:

Create AWS VPC, IGW, NAT-GW, subnets (2 public, 2 private in AZ-a & AZ-b), and route tables using Terraform.
Tag subnets per EKS requirements and route private subnet traffic via NAT-GW.
Subtask 3:

Use eksctl to create an EKS cluster in the custom VPC with public+private access.
Enable OIDC, create 2 nodegroups (private & public subnet, t2.medium), and configure kubectl.
Subtask 4:

Install AWS Load Balancer Controller, Kubernetes Metrics Server, and Cluster Autoscaler add-ons.
Subtask Bonus:

Explain security groups created during the EKS cluster setup.

**Task 2:**

*Task 2: Deploy Node Application on EKS Cluster*
Subtask 1:

Create an ECR repository for the node.js application image.
Write a Dockerfile to containerize the upg-loadme app, install dependencies, and expose it on port 8081.
Test Docker build and run locally, then push the image to ECR.
Ensure the app returns "hello world" on the root endpoint.
Subtask 2:

Create a nodegroup with a taint (desired count = 1, min = 0, max = 5, instance type = t2.medium or similar) using eksctl.
Add the nodegroup to the eksctl config and create it.
Subtask 3:

Create a demo namespace in Kubernetes.
Deploy the upg-loadme app using Kubernetes deployment, service, and ingress in the demo namespace.
Add toleration for the taint in the deployment, use the Docker image from ECR, and configure ingress to create an internet-facing ALB.
Test the root endpoint of the application.

**Task 3:**

*Task 3: Deploy Stateful Application (Redis) on EKS Cluster*
Subtask 1:

Deploy a Redis server using StatefulSet in the demo namespace.
Use the official Redis Alpine v6+ Docker image.
Configure the Redis server using a ConfigMap with the following settings:
dir /var/lib/redis
appendonly yes
protected-mode no
Use a Persistent Volume Claim (PVC) for /var/lib/redis directory with EBS.
Limit CPU to 200m and memory to 200Mi.
Create a ClusterIP service to expose the Redis StatefulSet on port 6379.
Subtask 2:

Deploy a Redis CLI pod in the demo namespace using a Deployment.
Use the Redis Docker image with the command /bin/sh and arguments:
-c
sleep 100000
Set the restartPolicy to Always.
Execute into the pod and keep it running without starting Redis.
Subtask 3:

Use redis-cli in the redis-cli pod to connect to the Redis service.
Store key-value pairs on the Redis server, e.g., SET foo 1.
Delete the redis-server-0 pod and let Kubernetes restart it.
Reconnect using redis-cli and verify the stored key-value pairs, e.g., GET foo.

**Task 4:**

*Task 4: Implement Horizontal Pod Autoscaler (HPA) and Load Testing*
Subtask 1:

Deploy a Horizontal Pod Autoscaler (HPA) for the upg-loadme app.
Set minReplicas to 1 and maxReplicas to 5.
Configure the app to scale up when CPU utilization exceeds 50%.
Verify the HPA in the demo namespace.
Subtask 2:

Install Prometheus on the cluster using the official Helm chart.
Use kubectl port-forward to access the Prometheus server locally via the Prometheus service.
Only install Prometheus for this task; additional charts like Alertmanager or Grafana are optional.
Subtask 3:

Generate load on the upg-loadme app using the Apache Benchmark (ab) tool.

Monitor the load on pods and watch the scaling activity.

Increase the load to trigger autoscaling.

After stopping the load test, wait for pods and nodes to scale down.



