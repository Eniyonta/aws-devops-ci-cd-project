terraform {
  backend "s3" {
    bucket = "devsecops-terraform-state-381491983429"
    key    = "devsecops/terraform.tfstate"
    region = "us-east-1"
  }
}
