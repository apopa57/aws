This is an example of a SAM application that uses an Amazon EventBridge Scheduler schedule to run at a specific rate.

## How to use
[Install the AWS SAM CLI](https://docs.aws.amazon.com/serverless-application-model/latest/developerguide/install-sam-cli.html) and deploy the application:
```
AWS_PROFILE=... sam deploy --guided
```
Here's an example of how to answer the questions in the guided deploy:
```
Configuring SAM deploy
======================

        Looking for config file [samconfig.toml] :  Found
        Reading default arguments  :  Success

        Setting default arguments for 'sam deploy'
        =========================================
        Stack Name [scheduled-lambda]:
        AWS Region [ap-northeast-1]:
        #Shows you resources changes to be deployed and require a 'Y' to initiate deploy
        Confirm changes before deploy [Y/n]: Y
        #SAM needs permission to be able to create roles to connect to the resources in your template
        Allow SAM CLI IAM role creation [Y/n]: Y
        #Preserves the state of previously provisioned resources when an operation fails
        Disable rollback [y/N]: N
        Save arguments to configuration file [Y/n]: Y
        SAM configuration file [samconfig.toml]:
        SAM configuration environment [default]:
```
Once the deploy is done, use the SAM CLI to get the logs of the function:
```
AWS_PROFILE=... sam logs --stack-name scheduled-lambda --tail
```
## Clean up
```
AWS_PROFILE=... sam delete
```
