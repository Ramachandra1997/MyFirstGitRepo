terraform {
    required_version = ">= 0.12"
}
provider "aws" {}

data "aws_caller_identity" "current" {}

locals {
    account_id = data.aws_caller_identity.current.account_id
}

 # With account id, this S3 bucket names can be *globally* unique.

resource "aws_s3_bucket" "terraform_state" {
    bucket = "${local.account_id}-terraform_states"

    versioning {
        enabled = true
    }
    server_side_encryption_configuration {
        rule {
            apply_server_side_encryption_by_default {
                sse_algorithm = "AES256"
            }
        }
    }
}

# ------------------------------------------------------------------------------
# CREATE THE DYNAMODB TABLE
# ------------------------------------------------------------------------------

resource "aws_dynamodb_table" "terraform_lock" {
    
}
