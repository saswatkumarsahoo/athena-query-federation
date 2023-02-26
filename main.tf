provider "aws" {
  region  = var.region
  profile = "default"
}

data "aws_caller_identity" "current" {}

locals {
  account_id = data.aws_caller_identity.current.account_id
}

resource "aws_serverlessapplicationrepository_cloudformation_stack" "athena-dynamodb-connector" {
  name           = "athena-dynamodb-connector"
  application_id = var.aws_serverlessapplicationrepository_app_id
  capabilities = [
    "CAPABILITY_IAM",
    "CAPABILITY_RESOURCE_POLICY",
  ]
  parameters = {
    AthenaCatalogName = var.athena_catalog_name
    SpillBucket       = aws_s3_bucket.athena-spill-bucket.id
    SpillPrefix       = "dynamodb"
    LambdaMemory      = 512
    LambdaTimeout     = 900
  }
}

resource "aws_s3_bucket" "athena-spill-bucket" {
  bucket        = "aws-athena-result-spill-${local.account_id}-${var.region}"
  force_destroy = true
}


resource "aws_athena_data_catalog" "dyanmodb-catalog" {
  name        = "dynamodb"
  description = "Athena data catalog for dynamodb tables"
  type        = "LAMBDA"

  parameters = {
    "function" = "arn:aws:lambda:eu-west-1:${local.account_id}:function:${var.athena_catalog_name}"
  }

}

