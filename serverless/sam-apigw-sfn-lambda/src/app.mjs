import AWS from 'aws-sdk';

const stepFunctions = new AWS.StepFunctions();

const stateMachineArn = process.env.STATE_MACHINE_ARN;

export const lambdaHandler = async (event, context) => {
    console.log({ stateMachineArn });

    const params = {
        stateMachineArn,
        input: '{}'
    };

    const result = await stepFunctions.startSyncExecution(params).promise();

    const stateMachineOutput = JSON.parse(result.output);

    console.log(`result: ${JSON.stringify(stateMachineOutput)}`);

    return stateMachineOutput;
};

export const lambdaHandler1 = async (event, context) => {
    return {
      lambdaHandler1: +new Date()
    };
};

export const lambdaHandler2 = async (event, context) => {
    return {
      lambdaHandler2: +new Date()
    };
};
