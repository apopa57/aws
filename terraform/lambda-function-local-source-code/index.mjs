export const lambdaHandler = async (event, context) => {
  console.log(JSON.stringify(event));

  return "Hello, world!";
};
