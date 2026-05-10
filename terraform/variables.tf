variable "aws_region" {
  default = "us-east-1"
}

variable "app_name" {
  default = "flask-cicd-app"
}

variable "ecr_image_uri" {
  description = "Full ECR image URI"
  type        = string
}
