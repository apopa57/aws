This directory contains a Terraform configuration that manages a bucket with name `lambda-function-different-account-source-code`. This bucket contains an object with key `index.mjs.zip`, which is a zip archive containing the file `index.zip` in this directory. This object can be read by any other AWS account and can be used to create a Lambda function in a different account, as exemplified by the Terraform configuration in the parent directory.

If you wish to inspect the contents of the `index.mjs.zip` object, you can do so as follows:
```
$ aws s3 cp s3://lambda-function-different-account-source-code/index.mjs.zip index.mjs.zip
download: s3://lambda-function-different-account-source-code/index.mjs.zip to ./index.mjs.zip

$ unzip index.mjs.zip
Archive:  index.mjs.zip
  inflating: index.mjs

$ cat index.mjs
export const lambdaHandler = async (event, context) => {
  console.log(JSON.stringify(event));
};
```
