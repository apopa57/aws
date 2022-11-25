var AWS = require('aws-sdk');

const stepFunctions = new AWS.StepFunctions();

const stateMachineArn = process.env.STATE_MACHINE_ARN;

exports.lambdaHandler = async (event, context) => {
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

