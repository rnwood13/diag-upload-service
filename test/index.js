var expect = require("chai").expect;
var request = require("request");

describe("Diagnostics Upload Service API", function () {

    describe("Health Check", function () {

        var url = "http://localhost:8000/";

        it("returns status 200", function (done) {
            request(url, function (error, response, body) {
                expect(response.statusCode).to.equal(200);
                done();
            });
        });

    });

});