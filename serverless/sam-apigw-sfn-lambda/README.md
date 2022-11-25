This is an example of a SAM application that uses a state machine to call Lambda functions in parallel.

## How to use
[Install the AWS SAM CLI](https://docs.aws.amazon.com/serverless-application-model/latest/developerguide/install-sam-cli.html) and deploy the application:
```
AWS_PROFILE=... sam deploy --guided --stack-name sam-apigw-sfn-lambda
```
Here's an example of how to answer the questions in the guided deploy:
```
Configuring SAM deploy
======================

        Looking for config file [samconfig.toml] :  Found
        Reading default arguments  :  Success

        Setting default arguments for 'sam deploy'
        =========================================
        Stack Name [sam-apigw-sfn-lambda]:
        AWS Region [ap-northeast-1]:
        #Shows you resources changes to be deployed and require a 'Y' to initiate deploy
        Confirm changes before deploy [Y/n]: Y
        #SAM needs permission to be able to create roles to connect to the resources in your template
        Allow SAM CLI IAM role creation [Y/n]: Y
        #Preserves the state of previously provisioned resources when an operation fails
        Disable rollback [Y/n]: n
        StateMachineCaller may not have authorization defined, Is this okay? [y/N]: y
        Save arguments to configuration file [Y/n]: Y
        SAM configuration file [samconfig.toml]:
        SAM configuration environment [default]:
```
The AWS SAM CLI will ask for confirmation and once the deployment is done, it will display the URL of the API gateway in the outputs.

You can also find the URL of the API gateway by querying for the CloudFormation stack outputs:
```
AWS_PROFILE=... aws cloudformation describe-stacks --stack-name sam-apigw-sfn-lambda --query "Stacks[0].Outputs[?OutputKey == 'HttpApiEndpoint'].OutputValue | join('', @)" --output text
```

Call the `/sm` endpoint, which executes a Lambda function that calls the state machine. The state machine executes two other Lambda functions in parallel. Tracing is enabled for the state machine and you can go to X-Ray in the AWS console to see traces.
```
curl {HttpApiEndpoint}/sm
```

## Clean up
```
AWS_PROFILE=... sam delete
```
