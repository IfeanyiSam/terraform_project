terraform {
  backend "s3" {
    bucket = "terraform-state-vprofile"
    key    = "terraform/backend"
    region = "us-east-1"
  }
}