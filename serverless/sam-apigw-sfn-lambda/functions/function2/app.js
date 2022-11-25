exports.lambdaHandler = async (event, context) => {
    return { '2': +new Date() };
};
