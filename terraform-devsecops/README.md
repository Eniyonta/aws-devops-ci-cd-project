# DevSecOps CI/CD Pipeline — Flask + Docker + GitHub Actions + AWS

A production-style DevSecOps pipeline that integrates automated security
scanning at every layer of the software delivery lifecycle. Nothing gets
deployed unless it passes all security checks.

---

## What This Project Is About

Traditional CI/CD pipelines deploy fast but deploy blindly. This project
adds a **security gate** to the pipeline — four automated security scans
run before any code reaches production. If any scan finds a critical
vulnerability, the pipeline fails and deployment is blocked automatically.

---

## Architecture

```
Push code to GitHub
        ↓
┌─────────────────────────────────────────┐
│     3 Security Scans (Parallel)         │
│  🔍 Snyk      → dependency scan         │
│  📊 SonarCloud → code quality scan      │
│  🏗️  Checkov   → Terraform/IaC scan     │
└─────────────────────────────────────────┘
        ↓ ALL must pass
🐳 Build Docker Image
        ↓
🛡️ Trivy → Docker image scan
        ↓ Must pass
🚀 Deploy to AWS ECS Fargate
        ↓
✅ App is live — all scans passed
```

---

## 🛠️ Tech Stack

| Tool | Purpose |
|------|---------|
| Python Flask | Web application |
| Docker | Containerization |
| GitHub Actions | CI/CD pipeline automation |
| Snyk | Dependency vulnerability scanning |
| SonarCloud | Code quality and security analysis |
| Checkov | Terraform infrastructure scanning |
| Trivy | Docker image vulnerability scanning |
| AWS ECR | Container image registry |
| AWS ECS Fargate | Serverless container deployment |
| Terraform | Infrastructure as Code |
| S3 | Terraform remote state backend |

---

## Project Structure

```
aws-devops-ci-cd-project/
├── app/
│   ├── app.py                  # Flask application
│   ├── requirements.txt        # Python dependencies
│   └── templates/
│       ├── page1.html
│       └── page2.html
├── terraform-devsecops/
│   ├── main.tf                 # Core infrastructure
│   ├── variables.tf            # Input variables
│   ├── outputs.tf              # Output values
│   └── backend.tf              # S3 remote state config
├── .github/
│   └── workflows/
│       └── devsecops.yml       # DevSecOps pipeline
├── Dockerfile                  # Container definition
├── .snyk                       # Snyk config
├── sonar-project.properties    # SonarCloud config
└── README.md
```

---

## Security Scans Explained

### 1. Snyk — Dependency Scanning
Scans `requirements.txt` for known vulnerabilities in Python packages.
Fails the pipeline if any HIGH or CRITICAL severity issues are found.

### 2. SonarCloud — Code Quality
Analyses the application source code for bugs, code smells, and
security hotspots. Catches issues like hardcoded credentials or
insecure coding patterns.

### 3. Checkov — Infrastructure Scanning
Scans Terraform files for misconfigurations before any infrastructure
is created. Catches issues like unencrypted S3 buckets, open security
groups, or missing IAM least-privilege policies.

### 4. Trivy — Container Image Scanning
Scans the built Docker image for OS and library vulnerabilities.
Only runs after the image is built — if it finds CRITICAL or HIGH
issues, the image is never pushed to ECR.

---

##  How to Run

### Prerequisites
- Python 3.12+
- Docker
- AWS CLI configured
- Terraform installed
- Snyk account ([snyk.io](https://snyk.io))
- SonarCloud account ([sonarcloud.io](https://sonarcloud.io))

### 1. Clone the repository
```bash
git clone https://github.com/Eniyonta/aws-devops-ci-cd-project.git
cd aws-devops-ci-cd-project
```

### 2. Run the app locally
```bash
python3 -m venv venv
source venv/bin/activate
pip install -r app/requirements.txt
python3 app/app.py
```
Visit `http://localhost:5000`

### 3. Run locally with Docker
```bash
docker build -t flask-devsecops .
docker run -p 5000:5000 flask-devsecops
```

### 4. Create S3 backend for Terraform state
```bash
aws s3 mb s3://devsecops-terraform-state-YOUR_ACCOUNT_ID \
  --region us-east-1

aws s3api put-bucket-versioning \
  --bucket devsecops-terraform-state-YOUR_ACCOUNT_ID \
  --versioning-configuration Status=Enabled
```

### 5. Deploy infrastructure with Terraform
```bash
cd terraform-devsecops
terraform init
terraform plan
terraform apply
```

---

## Required GitHub Secrets

Go to **Settings → Secrets and variables → Actions** and add:

| Secret | Description | Where to get it |
|--------|-------------|----------------|
| `AWS_ACCESS_KEY_ID` | AWS access key | AWS Console → IAM → Security credentials |
| `AWS_SECRET_ACCESS_KEY` | AWS secret key | Same as above |
| `SNYK_TOKEN` | Snyk API token | snyk.io → Account Settings → Auth Token |
| `SONAR_TOKEN` | SonarCloud token | sonarcloud.io → My Account → Security |

---

## 🔄 Pipeline Jobs

| Job | Depends On | What it does |
|-----|-----------|--------------|
| `snyk-scan` | nothing | Scans Python dependencies |
| `sonarcloud-scan` | nothing | Analyses code quality |
| `checkov-scan` | nothing | Scans Terraform for misconfigs |
| `build` | All 3 scans | Builds Docker image + Trivy scan |
| `deploy` | build | Deploys to ECS Fargate |

---

## How Pipeline Failures Work

| Scenario | Result |
|----------|--------|
| Snyk finds HIGH vulnerability | Pipeline fails at `snyk-scan` — nothing deploys |
| SonarCloud finds security hotspot | Pipeline fails at `sonarcloud-scan` |
| Checkov finds open S3 bucket | Pipeline fails at `checkov-scan` |
| Trivy finds CRITICAL CVE in image | Pipeline fails at `build` — image not pushed |
| All scans pass | Image pushed to ECR → deployed to ECS |

---

## 📊 Example Pipeline Output

```
✅ Snyk Dependency Scan        — No high/critical vulnerabilities found
✅ SonarCloud Code Quality     — Quality gate passed
✅ Checkov Terraform Scan      — No misconfigurations found
✅ Build Docker Image          — Image built successfully
✅ Trivy Image Scan            — No critical vulnerabilities found
✅ Deploy to ECS               — Deployment successful
```

---

## 📸 Screenshots

| Screenshot | Description |
|-----------|-------------|
| `screenshots/01-pipeline-green.png` | All 5 jobs passing |
| `screenshots/02-snyk-results.png` | Snyk scan output |
| `screenshots/03-trivy-results.png` | Trivy scan output |
| `screenshots/04-checkov-results.png` | Checkov scan output |
| `screenshots/05-sonarcloud-dashboard.png` | SonarCloud dashboard |
| `screenshots/06-pipeline-failed.png` | Pipeline blocked on vulnerability |
| `screenshots/07-terraform-apply.png` | Terraform apply output |
| `screenshots/08-s3-state.png` | S3 bucket with state file |

---

## 💡 Key Concepts Demonstrated

- **Shift Left Security** — security checks happen early in the pipeline,
  not after deployment
- **Defense in Depth** — four different tools each check a different layer
- **Pipeline as Policy** — security rules are enforced automatically,
  not manually
- **Infrastructure as Code Security** — Terraform is scanned before
  any resources are created
- **Zero Trust Deployment** — nothing is trusted until it is verified

---

## Cleanup

To destroy all AWS infrastructure:
```bash
cd terraform-devsecops
terraform destroy
```

---

## 👤 Author

**Eniyonta**
GitHub: [@Eniyonta](https://github.com/Eniyonta)
