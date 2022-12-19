The Terraform configuration in this directory shows how to deploy a simple Lambda function with a URL for which the source code is stored locally.

## How to use
First, make sure you have the Terraform CLI installed.

`cd` into this directory and run `terraform init` so Terraform can download the providers.

To apply the configuration, run the following command and confirm the changes:
```
AWS_PROFILE=... terraform apply
```
Once the configuration is applied, it will display the function URL. You can call the function by making an HTTP request to the function URL.

If you want to make changes to the function handler, update `index.mjs` and run the following commands (these are necessary because apparently the archive provider does not detect the contents of the resource has changed):
```
terraform taint aws_lambda_function.function
terraform taint aws_lambda_permission.allow_url_invocations
```
Then, apply the configuration again and confirm the changes.

## Clean up
```
AWS_PROFILE=... terraform destroy
```
