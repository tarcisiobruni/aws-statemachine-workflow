'use strict';

const app = require('../../app.js');
const chai = require('chai');
const expect = chai.expect;
var event, context;

describe('Tests Num Enricher', function () {
    it('Verifies response', async () => {
        event = {
            'number': 25
        }
        const result = await app.lambdaHandler(event, context)

        expect(result).to.be.an('object');
        expect(result).to.have.all.keys('id', 'number', 'timestamp');
    });
});
