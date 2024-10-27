terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "ap-southeast-2"
  #shared_config_files      = ["~/.aws/config"]
  #shared_credentials_files = ["~/.aws/credentials"]
  access_key = var.access_key
  secret_key = var.secret_key
  profile    = "vscode"
}