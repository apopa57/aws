This directory contains a Terraform configuration that demonstrates how to create a Lambda function for which the handler code is stored in an S3 bucket in a different AWS account.

Please note that in this case the handler doesn't have any npm dependencies so this use case works for functions that depend only on the standard node libraries or the AWS JavaScript SDK included with the runtime.
