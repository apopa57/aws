This example demonstrates that Terraform input variables passed via `TF_VAR_` environment variables behave different in root and child modules.

The configuration in this directory does not create any resources in the cloud. It consists of a root module with two input variables, `a` and `b`, which calls a local module with one input variable.

## How to use it
First, run `terraform init`.

Export the following environment variables:
```
export TF_VAR_a='value from TF_VAR_a environment variable'
export TF_VAR_b='value from TF_VAR_b environment variable'
```

Run `terraform apply`. The output will show:
```
Outputs:

a_from_root = "value from TF_VAR_a environment variable"
b_from_child = "default value of b"
b_from_root = "value from TF_VAR_b environment variable"
```

This shows that the value of the `TF_VAR_b` was not used in the child module for the value of the input variable `b`.
