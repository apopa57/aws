This example shows how to create and update Node.js Lambda functions using the AWS CLI.

## How to create the Lambda function
First, create the IAM role that the function will use:
```
aws iam create-role --role-name aws-cli-simple-lambda-role --assume-role-policy '{"Version": "2012-10-17", "Statement": [{"Principal": {"Service": "lambda.amazonaws.com"}, "Effect": "Allow", "Action": "sts:AssumeRole"}]}'
```

Next, attach the `AWSLambdaBasicExecutionRole` managed policy, so that the function can create a CloudWatch Logs log group, log stream, and put events to the log streams:
```
aws iam attach-role-policy --role-name aws-cli-simple-lambda-role --policy-arn "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
```

To avoid putting an AWS account ID in this file, let's save the role ARN in an environment variable:
```
ROLE_ARN=$(aws iam get-role --role-name aws-cli-simple-lambda-role --query Role.Arn --output text)
```

Install the packages and create a zip archive containing the file that includes the Lambda handler and its dependencies:
```
npm ci
zip -r function index.mjs package.json node_modules/
```

Finally, create the Lambda function:
```
aws lambda create-function --function-name aws-cli-simple-lambda --runtime nodejs18.x --role $ROLE_ARN --handler index.lambdaHandler --zip-file fileb://function.zip
```

## How to update the Lambda function
To update the function, change `index.mjs` (eventually adding new npm packages), recreate the zip archive, and update the function code as follows:
```
zip -r function index.mjs package.json node_modules/
aws lambda update-function-code --function-name aws-cli-simple-lambda --zip-file fileb://function.zip
```

## Cleanup
```
aws lambda delete-function --function-name aws-cli-simple-lambda
aws iam detach-role-policy --role-name aws-cli-simple-lambda-role --policy-arn "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
aws iam delete-role --role-name aws-cli-simple-lambda-role
```
