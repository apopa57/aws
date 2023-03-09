terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = ">= 4.36"
    }
  }
}

provider "aws" {
  region  = "us-east-1"
}

data "aws_caller_identity" "current" {}

locals {
  account_id = data.aws_caller_identity.current.account_id
}

resource "aws_iam_role" "role1" {
  name = "role1"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
	  "sts:AssumeRole",
	  "sts:TagSession" # This is required if this role is supposed to be assumed by a principal in a different account
	]
        Principal = {
          AWS = local.account_id
        }
      }
    ]
  })

  inline_policy {
    name = "AllowAssumeOtherRole"
    policy = jsonencode({
      Version = "2012-10-17"
      Statement = [
        {
          Action   = ["sts:AssumeRole"]
          Effect   = "Allow"
          Resource = "*"
        }
      ]
    })
  }
}

resource "aws_iam_role" "role2" {
  name = "role2"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
	  "sts:AssumeRole",
	  "sts:TagSession" # This is required if this role is supposed to be assumed by a principal in a different account
	]
        Principal = {
          AWS = "arn:aws:iam::${local.account_id}:role/${aws_iam_role.role1.name}"
        }
      }
    ]
  })

  inline_policy {
    name = "AllowS3"
    policy = jsonencode({
      Version = "2012-10-17"
      Statement = [
        {
          Action   = ["s3:*"]
          Effect   = "Allow"
          Resource = "*"
        }
      ]
    })
  }
}

output "role1-arn" {
  value = aws_iam_role.role1.arn
}

output "role2-arn" {
  value = aws_iam_role.role2.arn
}

