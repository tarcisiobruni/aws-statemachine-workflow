const crypto = require("crypto");

function getRandomInt(max) {
    return Math.floor(Math.random() * Math.floor(max)) + 1;
}

/**
 *  It simply returns a mocked result.
 * 
 * @param {Object} event - Input event to the Lambda function
 * @param {Object} context - Lambda Context runtime methods and attributes
 *
 * @returns {Object} object - Object containing details of the number
 * 
 */
exports.lambdaHandler = async (event, context) => {
    // Get the number of the provided as input
    var number = event["number"]
    var date = new Date();
    // Mocked result of a number buying transaction
    let transaction_result = {
        'id': crypto.randomBytes(16).toString("hex"), // Unique ID for the transaction
        'number': number.toString(), // number of each share
        'timestamp': date.toISOString(),  // Timestamp of the when the transaction was completed
    }
    return transaction_result
};
