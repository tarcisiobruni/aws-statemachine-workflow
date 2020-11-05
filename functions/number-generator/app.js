function getRandomInt(max) {
    return Math.floor(Math.random() * Math.floor(max));
}

/**
 * Lambda function that simply returns a random integer between 0 and 100 as the number.
 * 
 * @param {Object} event - Input event to the Lambda function
 * @param {Object} context - Lambda Context runtime methods and attributes
 *
 * @returns {Object} object - Object containing the current number
 * 
 */
exports.lambdaHandler = async (event, context) => {
    console.log(event);
    var number = getRandomInt(100);
    return { 'number': number }
};
