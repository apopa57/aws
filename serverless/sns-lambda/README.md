This is an example of a SAM application that creates an SNS topic and a Lambda function that executes whenever there are new messages published to the topic.

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
        Stack Name [sam-app]: sns-lambda
        AWS Region [ap-northeast-1]:
        #Shows you resources changes to be deployed and require a 'Y' to initiate deploy
        Confirm changes before deploy [y/N]: y
        #SAM needs permission to be able to create roles to connect to the resources in your template
        Allow SAM CLI IAM role creation [Y/n]: Y
        #Preserves the state of previously provisioned resources when an operation fails
        Disable rollback [y/N]: N
        Save arguments to configuration file [Y/n]: y
        SAM configuration file [samconfig.toml]:
        SAM configuration environment [default]:
```
Once the deploy is done, use the SAM CLI to get the logs of the function:
```
AWS_PROFILE=... sam logs --stack-name sns-lambda --tail
```
Then use the AWS CLI to send a message to the topic and observe the function being executed in the output of the previous command:
```
aws --profile ... sns publish --topic-arn arn:aws:sns:ap-northeast-1:{aws_account_id}:t --message "Hello world"
```

## Clean up
```
AWS_PROFILE=... sam delete --config-file samconfig.toml
```
