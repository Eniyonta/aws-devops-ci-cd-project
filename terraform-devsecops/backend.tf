terraform {
  backend "s3" {
    bucket = "devsecops-terraform-state-590183891242"
    key    = "devsecops/terraform.tfstate"
    region = "us-east-1"
  }
}
