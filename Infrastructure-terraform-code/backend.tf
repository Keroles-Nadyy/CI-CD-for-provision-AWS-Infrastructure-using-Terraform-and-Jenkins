terraform {
  backend "s3" {
    bucket         = "terraform-iti-cloud-pd44"
    key            = "terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "state-lock-iti"
  }
}
