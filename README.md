# **AWS CI/CD Pipeline with ECS Fargate - Terraform Project**

![AWS CI/CD Pipeline](https://img.shields.io/badge/AWS-CI%2FCD%20Pipeline-orange)  
![Terraform](https://img.shields.io/badge/Terraform-Infrastructure%20as%20Code-blue)  
![ECS Fargate](https://img.shields.io/badge/Amazon%20ECS-Fargate-lightgrey)  

This project automates the deployment of a **containerized application** on **AWS ECS Fargate** using a **CI/CD pipeline** with **CodeCommit, CodeBuild, CodePipeline, and CodeDeploy**.  

## **🚀 Features**
- **Infrastructure as Code (IaC)** using Terraform.
- **Automated CI/CD Pipeline**:
  - **CodeCommit**: Source code repository.
  - **CodeBuild**: Builds Docker images and pushes to ECR.
  - **CodePipeline**: Orchestrates the deployment workflow.
  - **CodeDeploy**: Deploys to ECS Fargate.
- **Secure Networking**:
  - Dedicated **VPC** with public & private subnets.
  - **ALB** for traffic distribution.
  - **Security Groups** with least-privilege access.
- **Scalable ECS Fargate**:
  - Task definitions, services, and auto-scaling (if configured).
  - **IAM roles** with least privilege.

---

## **📂 Project Structure**
```
terraform/
├── main.tf           # Core infrastructure (VPC, ALB, ECR, CodeCommit)
├── variables.tf      # Configurable parameters (region, CIDR, etc.)
├── outputs.tf        # Useful outputs (ALB DNS, CodeCommit URL)
├── iam.tf            # IAM roles & policies (CodeBuild, CodePipeline, ECS)
└── ecs.tf            # ECS resources (Cluster, Task, Service)
```

---

## **⚙️ Prerequisites**
1. **AWS Account** with admin/appropriate permissions.
2. **AWS CLI** configured (`aws configure`).
3. **Terraform** installed (`v1.0+`).
4. **Git** for version control.
5. **Docker** (for local testing).

---

## **🚀 Deployment Steps**
### **1. Clone the Repository**
```bash
git clone https://github.com/your-repo/aws-ecs-cicd-terraform.git
cd aws-ecs-cicd-terraform/terraform
```

### **2. Initialize Terraform**
```bash
terraform init
```

### **3. Review & Apply Infrastructure**
```bash
terraform plan   # Review changes
terraform apply -auto-approve
```

### **4. Push Code to CodeCommit**
```bash
git remote add origin $(terraform output -raw codecommit_repo_url)
git push origin main
```

### **5. Access the Application**
- **ALB DNS URL** (After pipeline completes):
  ```bash
  echo "Application URL: http://$(terraform output -raw alb_dns_name)"
  ```
- **Pipeline Status**:
  ```bash
  echo "Pipeline URL: $(terraform output -raw codepipeline_url)"
  ```

---

## **🔧 Customization**
Edit `variables.tf` to modify:
- **AWS region** (`aws_region`).
- **VPC CIDR** (`vpc_cidr`).
- **ECS CPU/Memory** (`ecs_task_cpu`, `ecs_task_memory`).
- **Subnet CIDRs** (`public_subnet_cidrs`, `private_subnet_cidrs`).

---

## **🧹 Cleanup**
To **destroy all AWS resources**:
```bash
terraform destroy -auto-approve
```

---

## **📜 Outputs**
| Output | Description |
|--------|-------------|
| `codecommit_repo_url` | Clone URL for the CodeCommit repository. |
| `ecr_repository_url` | ECR repository URL for Docker images. |
| `alb_dns_name` | DNS name of the Application Load Balancer. |
| `codepipeline_url` | AWS Console URL for the CI/CD pipeline. |

---

## **📌 Notes**
- The pipeline **automatically triggers** on `git push`.
- **ECS Fargate** ensures **serverless container deployment**.
- **ALB** provides **load balancing** and **high availability**.

---

## **📚 References**
- [AWS ECS Documentation](https://docs.aws.amazon.com/ecs/)
- [Terraform AWS Provider](https://registry.terraform.io/providers/hashicorp/aws/latest/docs)
- [AWS CI/CD Best Practices](https://aws.amazon.com/devops/continuous-delivery/)

---

## **📄 License**
MIT License. See [LICENSE](LICENSE) for details.

---

**🚀 Happy Deploying!**  
_Feel free to contribute or open issues!_