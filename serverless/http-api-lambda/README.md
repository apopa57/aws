This is an example of a SAM application that creates an API Gateway HTTP API and a Lambda function that is executed whenever an HTTP request is made to a specific path of the HTTP API.

## How to use
First, [install the AWS SAM CLI](https://docs.aws.amazon.com/serverless-application-model/latest/developerguide/install-sam-cli.html).

Next, build and deploy the application:
```
sam build
AWS_PROFILE=... sam deploy --guided
```
Here's an example of how to answer the questions in the guided deploy:
```
Configuring SAM deploy
======================

        Looking for config file [samconfig.toml] :  Not found

        Setting default arguments for 'sam deploy'
        =========================================
        Stack Name [sam-app]: http-api-lambda
        AWS Region [ap-northeast-1]:
        #Shows you resources changes to be deployed and require a 'Y' to initiate deploy
        Confirm changes before deploy [y/N]: y
        #SAM needs permission to be able to create roles to connect to the resources in your template
        Allow SAM CLI IAM role creation [Y/n]: y
        #Preserves the state of previously provisioned resources when an operation fails
        Disable rollback [y/N]: n
        LambdaFunction may not have authorization defined, Is this okay? [y/N]: y
        Save arguments to configuration file [Y/n]: y
        SAM configuration file [samconfig.toml]:
        SAM configuration environment [default]:
```
Once the deploy is done, use the SAM CLI to get the logs of the function:
```
AWS_PROFILE=... sam logs --stack-name http-api-lambda --tail
```
Then use curl to execute the Lambda function via the API Gateay and observe the function being executed in the output of the previous command:
```
curl $(aws --profile ... cloudformation describe-stacks --stack-name http-api-lambda --query "Stacks[0].Outputs[?OutputKey == 'ApiEndpoint'].OutputValue" --output text)/lambda_function --data '{"test": true }'
```

## Clean up
```
AWS_PROFILE=... sam delete --config-file samconfig.toml
```
