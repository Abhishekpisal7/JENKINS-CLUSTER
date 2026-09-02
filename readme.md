# 🚀 Jenkins Cluster on AWS with Terraform

A scalable and secure **Jenkins CI/CD infrastructure** deployed on **AWS using Terraform**.

This project provisions a complete Jenkins infrastructure stack including a **VPC, public and private subnets, Application Load Balancer, Jenkins controller, auto-scaling Jenkins agents, NAT Gateway, bastion host, security groups, and routing infrastructure**.

The Jenkins controller and build agents run inside private subnets, while the Application Load Balancer provides external access to the Jenkins interface.

---

## 🏗️ Architecture

```text
                              ┌─────────────────┐
                              │     Internet    │
                              └────────┬────────┘
                                       │
                                       ▼
                              ┌─────────────────┐
                              │      ALB        │
                              │  Port 80 / HTTP │
                              └────────┬────────┘
                                       │
                                       ▼
┌────────────────────────────────────────────────────────────────┐
│                           AWS VPC                              │
│                                                                │
│   ┌──────────────────── PUBLIC SUBNET ────────────────────┐   │
│   │                                                       │   │
│   │   ┌───────────────┐          ┌─────────────────┐     │   │
│   │   │      ALB      │          │ Bastion Host    │     │   │
│   │   └───────┬───────┘          └────────┬────────┘     │   │
│   │           │                           │              │   │
│   └───────────┼───────────────────────────┼──────────────┘   │
│               │                           │                  │
│               ▼                           │ SSH              │
│   ┌──────────────────── PRIVATE SUBNET ───────────────────┐   │
│   │                                                       │   │
│   │        ┌──────────────────────┐                      │   │
│   │        │  Jenkins Controller  │                      │   │
│   │        └──────────┬───────────┘                      │   │
│   │                   │                                  │   │
│   │                   ▼                                  │   │
│   │        ┌──────────────────────┐                      │   │
│   │        │ Jenkins Agent ASG    │                      │   │
│   │        │                      │                      │   │
│   │        │  Agent 1             │                      │   │
│   │        │  Agent 2             │                      │   │
│   │        │  Agent 3             │                      │   │
│   │        │  Agent 4             │                      │   │
│   │        └──────────────────────┘                      │   │
│   │                                                       │   │
│   └───────────────────────────────────────────────────────┘   │
│                           │                                   │
│                           ▼                                   │
│                    ┌─────────────┐                            │
│                    │ NAT Gateway │                            │
│                    └──────┬──────┘                            │
│                           │                                   │
└───────────────────────────┼───────────────────────────────────┘
                            │
                            ▼
                     Internet Gateway
```

The repository's architecture places the **ALB and bastion host in public subnets**, while the **Jenkins controller and agents run in private subnets**.

---

# 🎯 Project Objective

The goal of this project is to build a **scalable Jenkins CI/CD platform on AWS** using Infrastructure as Code.

Instead of manually creating Jenkins infrastructure through the AWS Console, Terraform provisions the complete environment in a repeatable and version-controlled manner.

The infrastructure provides:

* 🔐 Secure private Jenkins infrastructure
* ⚖️ Load-balanced Jenkins access
* 📈 Auto-scaling Jenkins agents
* 🌐 Isolated AWS networking
* 🛡️ Security-group-based traffic control
* 🔑 Bastion-based private resource access
* ♻️ Reproducible infrastructure using Terraform

---

# 🚀 Key Features

## 🔐 Secure Jenkins Architecture

The Jenkins controller is deployed inside a **private subnet**, preventing direct exposure to the public internet.

External users access Jenkins through:

```text
Internet
   │
   ▼
Application Load Balancer
   │
   ▼
Private Jenkins Controller
```

This provides an additional security layer compared with exposing the Jenkins instance directly.

---

## ⚖️ Application Load Balancer

An AWS Application Load Balancer provides the public entry point for Jenkins.

```text
User
 │
 ▼
ALB
 │
 ▼
Jenkins Controller
```

The ALB exposes Jenkins on port `80`, while the controller remains in the private network.

---

# 📈 Auto-Scaling Jenkins Agents

The project uses an **Auto Scaling Group** for Jenkins build agents.

```text
                    Jenkins Controller
                           │
                           ▼
                  ┌─────────────────┐
                  │  Agent ASG      │
                  └────────┬────────┘
                           │
              ┌────────────┼────────────┐
              │            │            │
              ▼            ▼            ▼
           Agent 1      Agent 2      Agent 3
```

The Auto Scaling Group is configured with a capacity ranging from **1 to 4 Jenkins agents**.

This allows build workloads to be distributed across multiple agents rather than depending on a single Jenkins machine.

---

# 🌐 AWS Network Architecture

The infrastructure uses a custom VPC with separate public and private networking.

### Public Subnet

Contains:

* Application Load Balancer
* Bastion Host

```text
Internet
   │
   ▼
Internet Gateway
   │
   ▼
Public Subnet
   ├── ALB
   └── Bastion
```

### Private Subnet

Contains:

* Jenkins Controller
* Jenkins Agents

```text
Public Subnet
      │
      ▼
Private Subnet
      │
      ├── Jenkins Controller
      │
      └── Jenkins Agents
```

The repository specifically implements this public/private subnet separation.

---

# 🌍 NAT Gateway

Private instances may require outbound internet access for tasks such as:

* Installing packages
* Downloading dependencies
* Pulling container images
* Accessing external services

Instead of giving private instances public IP addresses, outbound traffic can flow through:

```text
Private EC2
    │
    ▼
Route Table
    │
    ▼
NAT Gateway
    │
    ▼
Internet Gateway
    │
    ▼
Internet
```

This allows outbound connectivity while keeping the Jenkins infrastructure private.

---

# 🔑 Bastion Host

A bastion host provides an administrative entry point into private infrastructure.

```text
Administrator
      │
      ▼
Bastion Host
      │
      │ SSH
      ▼
Private Jenkins Resources
```

This avoids exposing the Jenkins controller directly to the public internet.

The repository provisions a dedicated bastion module for this purpose.

---

# 🛡️ Security Groups

Separate security groups are used for different infrastructure components.

The repository includes security-group configurations for:

```text
Bastion
Jenkins Controller
Load Balancer
Jenkins Agents
```

Traffic is restricted according to the role of each component.

A simplified communication model is:

```text
Internet
   │
   │ HTTP
   ▼
  ALB
   │
   │ Jenkins traffic
   ▼
Jenkins Controller
   │
   │ Agent communication
   ▼
Jenkins Agents
```

---

# 🧩 Terraform Module Architecture

The project follows a modular Terraform design.

```text
                    Terraform Environment
                            │
          ┌─────────────────┼─────────────────┐
          │                 │                 │
          ▼                 ▼                 ▼
        Network          Jenkins           Security
        Modules           Modules           Modules
          │                 │                 │
          ▼                 ▼                 ▼
         VPC            Controller       Security Groups
       Subnets             │
    Route Tables            ▼
    NAT Gateway          Agents ASG
    Internet GW
                            │
                            ▼
                           ALB
```

The repository contains reusable modules for:

```text
modules/
├── alb/
├── autoscaling/
├── bastion/
├── internet-gateway/
├── jenkins-controller/
├── nat-gateway/
├── route-tables/
├── security-groups/
├── subnets/
└── vpc/
```

These modules are present in the current repository structure.

---

# 📂 Project Structure

```text
JENKINS-CLUSTER/
│
├── environments/
│   └── dev/
│       ├── backend.tf
│       ├── locals.tf
│       ├── main.tf
│       ├── outputs.tf
│       ├── provider.tf
│       ├── terraform.tfvars
│       └── variable.tf
│
├── files/
│   ├── autojoining_agent.sh.tftpl
│   └── newkey.pem
│
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
│
└── README.md
```

The repository currently contains a `dev` Terraform environment, reusable infrastructure modules, and Jenkins agent auto-joining configuration.

---

# 🛠️ Technology Stack

| Technology                    | Purpose                        |
| ----------------------------- | ------------------------------ |
| **AWS**                       | Cloud infrastructure           |
| **Terraform**                 | Infrastructure as Code         |
| **Jenkins**                   | CI/CD automation               |
| **EC2**                       | Jenkins controller and agents  |
| **Auto Scaling Group**        | Jenkins agent scalability      |
| **Application Load Balancer** | Jenkins traffic distribution   |
| **VPC**                       | Network isolation              |
| **NAT Gateway**               | Private subnet outbound access |
| **Internet Gateway**          | Internet connectivity          |
| **Security Groups**           | Network access control         |
| **Bastion Host**              | Secure administrative access   |

---

# ⚙️ Prerequisites

Before deploying the infrastructure, make sure you have:

* Terraform installed
* AWS CLI installed
* AWS credentials configured
* An AWS account with sufficient permissions
* An AWS EC2 key pair
* Jenkins controller AMI
* Jenkins agent AMI

These prerequisites correspond to the requirements documented in the repository.

---

# 🚀 Deployment

## 1. Clone the Repository

```bash
git clone https://github.com/Abhishekpisal7/JENKINS-CLUSTER.git

cd JENKINS-CLUSTER
```

---

## 2. Navigate to the Environment

```bash
cd environments/dev
```

---

## 3. Initialize Terraform

```bash
terraform init
```

This initializes the Terraform working directory and downloads required providers/modules.

---

## 4. Validate the Configuration

```bash
terraform validate
```

---

## 5. Format Terraform Files

From the project root:

```bash
terraform fmt -recursive
```

---

## 6. Create a Terraform Plan

```bash
terraform plan -var-file=terraform.tfvars
```

Review the resources before applying the infrastructure.

---

## 7. Deploy

```bash
terraform apply -var-file=terraform.tfvars
```

Terraform will provision the AWS infrastructure.

The repository follows this deployment workflow in its current documentation.

---

# 🌐 Accessing Jenkins

After Terraform finishes successfully, retrieve the Application Load Balancer DNS name from the Terraform outputs.

```text
http://<ALB-DNS-NAME>
```

Traffic flows through:

```text
User
 │
 ▼
Application Load Balancer
 │
 ▼
Private Jenkins Controller
```

The ALB DNS name is exposed through the Terraform configuration outputs.

---

# 🖥️ Accessing Private Resources

The bastion host can be used to access private infrastructure.

```text
Local Machine
      │
      │ SSH
      ▼
Bastion Host
      │
      │ SSH
      ▼
Private Jenkins Controller
```

This provides a controlled administrative access path without exposing private instances directly.

---

# 🔄 Jenkins Agent Architecture

Jenkins uses a controller-agent architecture:

```text
                 Jenkins Controller
                        │
                 Build / Job Queue
                        │
          ┌─────────────┼─────────────┐
          │             │             │
          ▼             ▼             ▼
       Agent 1       Agent 2       Agent 3
          │             │             │
          ▼             ▼             ▼
       Build         Build         Build
```

The project uses an Auto Scaling Group to provide Jenkins agents dynamically according to the configured capacity.

The repository also contains an `autojoining_agent.sh.tftpl` template for agent setup/joining.

---

# 🔐 Security Considerations

The architecture is designed around private infrastructure.

### Jenkins Controller

```text
❌ Direct public access
        ↓
✅ Private subnet
        ↓
✅ ALB access
```

### Jenkins Agents

```text
❌ Public IP
        ↓
✅ Private subnet
        ↓
✅ Controlled Jenkins communication
```

### Administration

```text
Administrator
      ↓
Bastion
      ↓
Private resources
```

This reduces the public attack surface of the Jenkins infrastructure.

---

# 🔁 Infrastructure Workflow

```text
Terraform Code
      │
      ▼
terraform init
      │
      ▼
terraform validate
      │
      ▼
terraform plan
      │
      ▼
Review Infrastructure
      │
      ▼
terraform apply
      │
      ▼
AWS Infrastructure
      │
      ├── VPC
      ├── Subnets
      ├── ALB
      ├── Jenkins Controller
      ├── Jenkins Agents
      ├── NAT Gateway
      ├── Bastion
      └── Security Groups
```

---

# 🧹 Destroy Infrastructure

When the environment is no longer required:

```bash
terraform destroy -var-file=terraform.tfvars
```

> ⚠️ Do not run `terraform destroy` against a production environment without first reviewing the resources that will be deleted.

---

# ⚠️ Security Warning

The repository currently contains a file named:

```text
files/newkey.pem
```

A private SSH key should **never be committed to a public GitHub repository**. The repository's file listing currently exposes that filename.

I strongly recommend:

1. Remove the private key from the repository.
2. Revoke/replace the corresponding AWS key pair if it has been used.
3. Remove it from Git history if it was committed previously.
4. Add the following to `.gitignore`:

```gitignore
*.pem
*.key
.env
*.tfvars
```

5. Use AWS Secrets Manager, SSM Parameter Store, or another secure secret-management mechanism for sensitive values.

The repository's own README also advises against committing credentials directly.

---

# 📊 Infrastructure Components

| Component          | Location  | Purpose                        |
| ------------------ | --------- | ------------------------------ |
| VPC                | AWS       | Network isolation              |
| Internet Gateway   | Public    | Internet connectivity          |
| NAT Gateway        | Public    | Private subnet outbound access |
| ALB                | Public    | Jenkins external access        |
| Bastion            | Public    | Administrative access          |
| Jenkins Controller | Private   | Jenkins orchestration          |
| Jenkins Agents     | Private   | Build execution                |
| Auto Scaling Group | Private   | Agent scalability              |
| Security Groups    | All tiers | Traffic control                |
| Route Tables       | VPC       | Network routing                |

---

# 🎯 DevOps Concepts Demonstrated

This project demonstrates practical experience with:

* Infrastructure as Code
* Terraform
* Terraform modules
* AWS networking
* VPC architecture
* Public/private subnet design
* Route tables
* Internet Gateway
* NAT Gateway
* Application Load Balancer
* EC2
* Auto Scaling Groups
* Jenkins controller-agent architecture
* Jenkins CI/CD infrastructure
* Bastion hosts
* Security Groups
* Terraform state
* Environment-based infrastructure
* Automated infrastructure provisioning
* Cloud security

---

<!-- # 📈 Future Improvements

Possible improvements to make this infrastructure more production-ready:

* [ ] Add HTTPS using AWS ACM
* [ ] Add Route 53 DNS
* [ ] Add AWS WAF
* [ ] Add CloudWatch monitoring
* [ ] Add CloudWatch Logs
* [ ] Add VPC Flow Logs
* [ ] Add S3 remote Terraform state
* [ ] Add state locking
* [ ] Add Terraform CI/CD with GitHub Actions
* [ ] Add TFLint
* [ ] Add Checkov
* [ ] Add automated Terraform security scanning
* [ ] Replace bastion host with AWS Systems Manager Session Manager
* [ ] Store secrets in AWS Secrets Manager
* [ ] Remove static SSH keys
* [ ] Add multi-AZ deployment
* [ ] Add Jenkins Configuration as Code
* [ ] Add Jenkins backup strategy
* [ ] Add disaster recovery strategy
* [ ] Add centralized monitoring and alerting -->

---

# 💡 What This Project Demonstrates

This project demonstrates how a Jenkins CI/CD platform can be deployed using **AWS + Terraform** rather than manually configuring individual cloud resources.

The infrastructure combines:

```text
AWS
 +
Terraform
 +
Networking
 +
Security
 +
Jenkins
 +
Auto Scaling
 +
Load Balancing
```

to create a reusable CI/CD platform capable of supporting multiple Jenkins build agents.

---

# 👨‍💻 Author

**Abhishek Pisal**

Computer Science Engineer | AWS | Terraform | Docker | Kubernetes | Jenkins | DevOps

### GitHub Repository

[JENKINS-CLUSTER](https://github.com/Abhishekpisal7/JENKINS-CLUSTER?utm_source=chatgpt.com)

---

## ⭐ Support

If you find this project useful, consider giving the repository a ⭐.
