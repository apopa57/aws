# AWS role chaining example with Terraform

This is a Terraform configuration that defines two IAM roles that exemplify [role chaining](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_roles_terms-and-concepts.html#iam-term-role-chaining)

`role1` can be assumed by any identity in the account and only allows assuming another role.

`role2` can only be assumed by `role1` and only allows S3 operations. (The decision to use S3 operations is arbitrary and meant to show the difference in permissions between the two roles.)

## Prerequisites
* Have AWS CLI installed
* Have an AWS CLI profile named `p`
* Have Terraform installed

## How to apply the configuration
Run the following:
```
terraform init
AWS_PROFILE=p terraform apply
```

## How to verify
In your `~/.aws/config` file, add the following lines to create three new profiles (make sure to replace `123456789012` with your account ID or just copy the role ARNs from the terraform output):
* one role that assumes `role1` based on the identity in profile `p`
* one role that assumes `role2` based on the identity in profile `p`
* one role that assumes `role2` based on `role1`:
```
[profile p-role1]
region = us-east-1
role_arn = arn:aws:iam::123456789012:role/role1
source_profile = p

[profile p-role1-role2]
region = us-east-1
role_arn = arn:aws:iam::123456789012:role/role2
source_profile = p-role1
```

Using the AWS CLI, check that assuming `role1` you do not have permission to do S3 operations:
```
$ aws --profile p-role1 s3 ls

An error occurred (AccessDenied) when calling the ListBuckets operation: Access Denied
```
but when assuming `role2` via `role1`, you do:
```
$ aws --profile p-role1-role2 s3 ls
# buckets listed
```
You might also want to check that it's not possible for the identity in profile `p` to assume `role2` directly:
```
$ aws --profile p sts assume-role --role-arn "arn:aws:iam::123456789012:role/role2" --role-session-name test

An error occurred (AccessDenied) when calling the AssumeRole operation: User: arn:aws:iam::123456789012:user/... is not authorized to perform: sts:AssumeRole on resource: arn:aws:iam::123456789012:role/role2
```

## Clean up
Run the following to delete the two roles:
```
AWS_PROFILE=p terraform destroy
```
Also delete the lines added to `~/.aws/config`.
