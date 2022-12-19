provider "aws" {
  region = "ap-northeast-1"
}

provider "archive" {}

data "archive_file" "index_mjs" {
  type        = "zip"
  source_file = "${path.module}/index.mjs"
  output_path = "${path.module}/index.mjs.zip"
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
  function_name = "lambda-function-local-source-code"
  role          = aws_iam_role.function_role.arn
  handler       = "index.lambdaHandler"
  runtime       = "nodejs18.x"
  filename      = data.archive_file.index_mjs.output_path
}

resource "aws_lambda_function_url" "function_url" {
  function_name      = aws_lambda_function.function.function_name
  authorization_type = "NONE"
}

resource "aws_lambda_permission" "allow_url_invocations" {
  action                 = "lambda:InvokeFunctionUrl"
  function_name          = aws_lambda_function.function.function_name
  principal              = "*"
  function_url_auth_type = "NONE"
}

output "function_url" {
  value = aws_lambda_function_url.function_url.function_url
}
