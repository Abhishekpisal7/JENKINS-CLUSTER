# Jenkins Cluster on AWS with Terraform

This repository provisions a Jenkins infrastructure stack on AWS using Terraform. The solution creates a secure network, a Jenkins controller, a load balancer, and an auto-scaling group of Jenkins agents to support CI/CD workloads.

## Overview

The Terraform configuration deploys the following components:

- A VPC with public and private subnets
- An Internet Gateway and NAT Gateway for outbound connectivity
- Route tables for public and private traffic
- Security groups for the bastion host, Jenkins controller, load balancer, and agents
- A bastion host for secure access to private resources
- A Jenkins controller instance placed in a private subnet
- An Application Load Balancer exposing Jenkins on port 80
- An Auto Scaling Group for Jenkins agents in private subnets

## Architecture Summary

The stack is organized as follows:

- Public subnet: bastion host and load balancer
- Private subnet: Jenkins controller and Jenkins agents
- Security groups: restrict access to required ports only
- Auto-scaling: adds or removes agents based on workload

## Repository Structure

```text
jenkins-cluster/
├── environments/
│   └── dev/
│       ├── backend.tf
│       ├── locals.tf
│       ├── main.tf
│       ├── outputs.tf
│       ├── provider.tf
│       ├── terraform.tfvars
│       └── variable.tf
├── files/
│   ├── autojoining_agent.sh.tftpl
│   └── newkey.pem
├── modules/
│   ├── alb/
│   ├── autoscaling/
│   ├── bastion/
│   ├── internet-gateway/
│   ├── jenkins-controller/
│   ├── nat-gateway/
│   ├── route-tables/
│   ├── security-groups/
│   ├── subnets/
│   └── vpc/
└── readme.md
```

## Prerequisites

Before deploying, make sure you have:

- Terraform installed
- AWS CLI configured with valid credentials
- An AWS account with permission to create EC2, VPC, ELB, and Auto Scaling resources
- A key pair available in the target AWS region
- Custom AMIs for Jenkins controller and Jenkins agents available in your account

## Configuration

The main environment variables are defined in:

- [environments/dev/terraform.tfvars](environments/dev/terraform.tfvars)

Update the values for:

- AWS region
- CIDR blocks
- instance sizes
- key names
- Jenkins credentials

> Do not commit secrets directly in plain text. Use a secure secret manager or environment-based injection for production deployments.

## Deployment Steps

Navigate to the development environment directory:

```bash
cd environments/dev
```

Initialize Terraform:

```bash
terraform init
```

Validate the configuration:

```bash
terraform validate
```

Preview the changes:

```bash
terraform plan -var-file=terraform.tfvars
```

Apply the infrastructure:

```bash
terraform apply -var-file=terraform.tfvars
```

## Accessing the Jenkins Cluster

After deployment:

- Jenkins can be accessed through the Application Load Balancer DNS name
- The bastion host can be used to SSH into private resources
- Jenkins agents are launched automatically by the Auto Scaling Group

The load balancer DNS name is exposed as an output from the Terraform configuration.

## Cleanup

To remove the deployed infrastructure:

```bash
terraform destroy -var-file=terraform.tfvars
```

## Notes

- This project uses a private-subnet design for the Jenkins controller and agents for better security.
- The Auto Scaling Group is configured to scale between 1 and 4 agents.
- The setup is intended for learning, testing, and small-to-medium CI/CD environments.