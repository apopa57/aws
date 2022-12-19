import semver from 'semver';

export const lambdaHandler = async (event, context) => {
  console.log(JSON.stringify(event));
  console.log(semver.valid('1.2.3'));

  return "Hello, world!";
};

