A simple Terraform module that creates an EC2 instance you can SSH into.

## How to use it
First, run `terraform init`. Then, apply the configuration using an AWS CLI profile:
```
AWS_PROFILE=... terraform apply
```

Take the IP from the output and SSH into the instance. Use the private key corresponding to the public key you passed in as a variable for `public_key_file`, if you didn't use the default value.
```
$ ssh -i ~/.ssh/id_rsa ec2-user@$(terraform output ec2_instance_public_ip | tr -d '"')
```

## Cleanup
```
AWS_PROFILE=... terraform destroy
```
