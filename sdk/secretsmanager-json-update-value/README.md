This is an example of how to use the AWS JavaScript SDK to update the value of a field in a SecretsManager secret which is in JSON format.

## How to run
First, run `npm  ci` in this directory to download the packages. Then, set the desired secret ID, key, and new value in `index.js` and execute the script using a command such as:
```
AWS_PROFILE=... npm run secretsmanager-json-update-value
```
You can check that the secret has been udpated by using the AWS CLI:
```
AWS_PROFILE=... aws secretsmanager get-secret-value --secret-id ... --query SecretString --output text | jq .
```
