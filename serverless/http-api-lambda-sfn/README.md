This is an example of a SAM application that uses a state machine to call Lambda functions in parallel.

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
        Stack Name [sam-app]: http-api-lambda-sfn
        AWS Region [ap-northeast-1]:
        #Shows you resources changes to be deployed and require a 'Y' to initiate deploy
        Confirm changes before deploy [y/N]: y
        #SAM needs permission to be able to create roles to connect to the resources in your template
        Allow SAM CLI IAM role creation [Y/n]: y
        #Preserves the state of previously provisioned resources when an operation fails
        Disable rollback [y/N]: n
        StateMachineCaller may not have authorization defined, Is this okay? [y/N]: y
        Save arguments to configuration file [Y/n]: y
        SAM configuration file [samconfig.toml]:
        SAM configuration environment [default]:
```
The AWS SAM CLI will ask for confirmation and once the deployment is done, it will display the URL of the API gateway in the outputs.

Use curl to call the API Gateway HTTP API endpoint that maps to the function that calls the state machine:
```
curl $(aws --profile apopa57 cloudformation describe-stacks --stack-name http-api-lambda-sfn --query "Stacks[0].Outputs[?OutputKey == 'HttpApiEndpoint'].OutputValue" --output text)/sm
```

The state machine executes two other Lambda functions in parallel. Tracing is enabled for the state machine and you can go to X-Ray in the AWS console to see traces.

## Clean up
```
AWS_PROFILE=... sam delete --config-file samconfig.toml
```
