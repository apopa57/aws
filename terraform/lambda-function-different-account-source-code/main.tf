provider "aws" {
  # ap-northeast-1 because the bucket is in this region
  region = "ap-northeast-1"
}

resource "aws_iam_role" "function_role" {
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Principal = {
        Service = "lambda.amazonaws.com"
      }
      Effect = "Allow"
      Action = "sts:AssumeRole"
    }]
  })
}

resource "aws_lambda_function" "function" {
  function_name = "nodejs18-function"
  role          = aws_iam_role.function_role.arn
  handler       = "index.lambdaHandler"
  runtime       = "nodejs18.x"
  s3_bucket     = "lambda-function-different-account-source-code"
  s3_key        = "index.mjs.zip"
}
