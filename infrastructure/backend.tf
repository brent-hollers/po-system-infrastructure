terraform {
  backend "s3" {
    bucket         = "hollers-po-tfstate-005608856189"
    key            = "prod/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "po-system-terraform-locks"
    encrypt        = true
  }
}
