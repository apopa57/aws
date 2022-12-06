const { SecretsManagerClient, GetSecretValueCommand, PutSecretValueCommand } =  require('@aws-sdk/client-secrets-manager');

const client = new SecretsManagerClient({ region: 'us-east-1' }); // set the region the secret is in

const main = async () => {
  const SecretId = '...' // set your secret ID
  const KEY_TO_CHANGE = '...'; // set the JSON key you wish to updated
  const NEW_VALUE = '...'; // set the new value of the key

  const getSecretValueCommand = new GetSecretValueCommand({ SecretId });
  const response = await client.send(getSecretValueCommand);
  const secretJson = JSON.parse(response.SecretString);

  secretJson[KEY_TO_CHANGE] = NEW_VALUE;

  const putSecretValueCommand = new PutSecretValueCommand({ SecretId, SecretString: JSON.stringify(secretJson) });
  await client.send(putSecretValueCommand);
};

main();
