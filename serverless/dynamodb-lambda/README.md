This is an example of a SAM application that creates a DynamoDB table and a Lambda function that executes whenever there are changes in the table.

## How to use
First, [install the AWS SAM CLI](https://docs.aws.amazon.com/serverless-application-model/latest/developerguide/install-sam-cli.html)

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
        Stack Name [sam-app]: dynamodb-lambda
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
Once the deploy is done, use the SAM CLI to get the logs of the function:
```
AWS_PROFILE=... sam logs --stack-name dynamodb-lambda --tail
```
Then use the AWS CLI to insert or change an item in the table and observe the function being executed in the output of the previous command:
```
aws --profile ... dynamodb put-item --table-name table --item '{ "id": {"S": "001"} }'
aws --profile ... dynamodb update-item --table-name table --key '{ "id": { "S": "001" } }' --update-expression "SET k = :value" --expression-attribute-values '{ ":value": { "S": "v2" } }'
```

## Clean up
```
AWS_PROFILE=... sam delete --config-file samconfig.toml
```
