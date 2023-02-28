provider "aws" {
  region  = var.region
  profile = "default"
}

data "aws_caller_identity" "current" {}

locals {
  account_id = data.aws_caller_identity.current.account_id
  json_data  = file("./data.json")
  table_data = jsondecode(local.json_data)
}

resource "aws_dynamodb_table" "movies_table" {
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "year"
  range_key    = "title"
  name         = "movies_table"
  attribute {
    name = "year"
    type = "S"
  }

  attribute {
    name = "title"
    type = "S"
  }

}

resource "aws_dynamodb_table_item" "movies_table_items" {
  table_name = aws_dynamodb_table.movies_table.name
  hash_key   = aws_dynamodb_table.movies_table.hash_key
  range_key  = aws_dynamodb_table.movies_table.range_key
  for_each   = local.table_data
  item       = jsonencode(each.value)
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

resource "aws_athena_data_catalog" "dyanmodb-catalog" {
  name        = "dynamodb"
  description = "Athena data catalog for dynamodb tables"
  type        = "LAMBDA"
  parameters = {
    "function" = "arn:aws:lambda:eu-west-1:${local.account_id}:function:${var.athena_catalog_name}"
  }

}

resource "aws_s3_bucket" "athena-spill-bucket" {
  bucket        = "aws-athena-result-spill-${local.account_id}-${var.region}"
  force_destroy = true
}



