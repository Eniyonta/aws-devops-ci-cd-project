# 🚀 CI/CD Pipeline — Flask + Docker + GitHub Actions + AWS ECS Fargate

## Overview
This project demonstrates a production-style CI/CD pipeline that automatically builds, 
containerizes, and deploys a Flask web app using:

- GitHub Actions
- Docker
- AWS ECS Fargate
- Amazon ECR
- Terraform
- Application Load Balancer

## Features
- Containerized Flask application
- Automated Docker builds
- CI/CD deployment pipeline
- AWS ECS deployment
- Infrastructure as Code with Terraform

## Tech Stack
| Tool | Purpose |
|------|---------|
| Python Flask | Web application |
| Docker | Containerization |
| GitHub Actions | CI/CD pipeline |
| AWS ECR | Container registry |
| AWS ECS Fargate | Serverless container hosting |
| AWS ALB | Load balancer |
| Terraform | Infrastructure as Code |

## Endpoints
/page1
/page2

## Architecture
Developer → GitHub → GitHub Actions → ECR → ECS Fargate → ALB → Users

## 📁 Project Structure
aws-devops-ci-cd-project/
├── app/                    # Flask application
├── terraform/              # Infrastructure as Code
├── .github/workflows/      # CI/CD pipeline
├── Dockerfile              # Container definition
└── README.md

## 🚀 How to Run Locally

```bash
# Build Docker image
docker build -t my-app .

# Run locally
docker run -p 5000:5000 my-app

# Visit
http://localhost:5000
```

## ☁️ Deploy Infrastructure

```bash
cd terraform
terraform init
terraform apply -var="ecr_image_uri=YOUR_ECR_URI"
```

## 🔄 CI/CD Flow

Every push to `main` automatically:
1. Builds a new Docker image
2. Tags it with the Git commit SHA
3. Pushes it to AWS ECR
4. Updates the ECS task definition
5. Deploys to ECS Fargate with zero downtime

## 🔐 Required GitHub Secrets

- `AWS_ACCESS_KEY_ID`
- `AWS_SECRET_ACCESS_KEY`  
- `AWS_ACCOUNT_ID`
# trigger pipeline
# DevSecOps Pipeline
# trigger
