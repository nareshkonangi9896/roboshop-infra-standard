terraform {
    required_providers {
        aws = {
            source = "hashicorp/aws"
            version = "5.55.0"
        }
    }
    backend "s3" {
        bucket = "roboshop-remote-dev-nar"
        key = "firewalls"
        region = "us-east-1"
        dynamodb_table = "Roboshop-lock-dev"
    }
}
provider "aws" {
    region = "us-east-1"
}