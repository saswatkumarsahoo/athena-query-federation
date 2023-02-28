# athena-query-federation 
This is an example terraform project to set up athena query federation usong dynamodb connector
<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 4.56.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_athena_data_catalog.dyanmodb-catalog](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/athena_data_catalog) | resource |
| [aws_dynamodb_table.movies_table](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/dynamodb_table) | resource |
| [aws_dynamodb_table_item.movies_table_items](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/dynamodb_table_item) | resource |
| [aws_s3_bucket.athena-spill-bucket](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket) | resource |
| [aws_serverlessapplicationrepository_cloudformation_stack.athena-dynamodb-connector](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/serverlessapplicationrepository_cloudformation_stack) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_athena_catalog_name"></a> [athena\_catalog\_name](#input\_athena\_catalog\_name) | n/a | `string` | `"athena-dynamodb-catalog"` | no |
| <a name="input_aws_serverlessapplicationrepository_app_id"></a> [aws\_serverlessapplicationrepository\_app\_id](#input\_aws\_serverlessapplicationrepository\_app\_id) | n/a | `string` | `"arn:aws:serverlessrepo:us-east-1:292517598671:applications/AthenaDynamoDBConnector"` | no |
| <a name="input_region"></a> [region](#input\_region) | n/a | `string` | `"eu-west-1"` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->

