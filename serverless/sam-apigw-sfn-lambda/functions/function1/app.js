exports.lambdaHandler = async (event, context) => {
    return { '1': +new Date() };
};
