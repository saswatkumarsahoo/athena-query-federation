variable "athena_catalog_name" {
  default = "athena-dynamodb-catalog"
}

variable "region" {
  default = "eu-west-1"
}

variable "aws_serverlessapplicationrepository_app_id" {
  default = "arn:aws:serverlessrepo:us-east-1:292517598671:applications/AthenaDynamoDBConnector"
}
