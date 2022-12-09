This is an example of a SAM application that creates an S3 bucket that publishes messages to an SNS topic whenever objects are created in the topic. For checking easily the messages published, a Lambda function is subscribed to the SNS topic.

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
        Stack Name [sam-app]: s3-bucket-notification-sns-lambda
        AWS Region [ap-northeast-1]:
        #Shows you resources changes to be deployed and require a 'Y' to initiate deploy
        Confirm changes before deploy [y/N]: y
        #SAM needs permission to be able to create roles to connect to the resources in your template
        Allow SAM CLI IAM role creation [Y/n]: y
        #Preserves the state of previously provisioned resources when an operation fails
        Disable rollback [y/N]: n
        Save arguments to configuration file [Y/n]: y
        SAM configuration file [samconfig.toml]:
        SAM configuration environment [default]:
```
AWS_PROFILE=... sam logs --stack-name s3-bucket-notification-sns-lambda --tail
```
Then use the AWS CLI to create a new object in the bucket and observe the function being executed in the output of the previous command:
```
aws --profile ... s3 cp template.yaml s3://$(aws --profile ... cloudformation describe-stacks --stack-name s3-bucket-notification-sns-lambda --query "Stacks[0].Outputs[?OutputKey=='BucketName'].OutputValue" --output text)/template.yaml
```
## Clean up
```
AWS_PROFILE=... sam delete --config-file samconfig.toml
```
