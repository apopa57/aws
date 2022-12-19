terraform {
  backend "s3" {
    bucket = "lambda-function-different-account-source-code"
    key    = "terraform.tfstate"
    region = "ap-northeast-1"
  }
}

provider "aws" {
  region = "ap-northeast-1"
}

provider "archive" {}

data "archive_file" "index_mjs" {
  type        = "zip"
  source_file = "${path.module}/index.mjs"
  output_path = "${path.module}/index.mjs.zip"
}

resource "aws_s3_bucket" "lambda_source_code_bucket" {
  bucket = "lambda-function-different-account-source-code"
}

resource "aws_s3_object" "index_mjs" {
  bucket = aws_s3_bucket.lambda_source_code_bucket.id
  key    = "index.mjs.zip"
  source = data.archive_file.index_mjs.output_path
}

resource "aws_s3_bucket_policy" "lambda_source_code_bucket_policy" {
  bucket = aws_s3_bucket.lambda_source_code_bucket.id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect   = "Allow"
      Action   = "s3:GetObject"
      Resource = "${aws_s3_bucket.lambda_source_code_bucket.arn}/${aws_s3_object.index_mjs.id}"
      Principal = "*"
    }]
  })
}
