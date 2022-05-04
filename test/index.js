var expect = require('chai').expect;
    supertest = require('supertest');
var request = require('request');
var superrequest = supertest('localhost:8000')

var fs = require('fs');

describe('Diagnostics Upload Service API', function () {
    let username = 'admin'
    let password = 'admin'
    let auth = 'Basic ' + Buffer.from(username + ':' + password).toString('base64');
    let headers = {
        'Host': 'localhost',
        'Authorization': auth
    };

    describe('Basic Health Check', function () {

        let url = 'http://localhost:8000/';

        it('returns status 401 - Unauthorized', function (done) {
            request(url, function (error, response, body) {
                expect(response.statusCode).to.equal(401);
                done();
            });
        });

    });

    describe('Basic Auth Check', function () {

        let url = 'http://localhost:8000/';

        it('returns status 200', function (done) {
            request.get({
                url: url,
                headers: headers
            }, function (error, response, body) {
                expect(response.statusCode).to.equal(200);
                done();
            });
        });

    });

    describe('Upload Test', function () {
        fs.writeFile('app/diags/test.tgz', 'This is a test', function (err) {
            if (err) throw err;
            console.log('Test file app/diags/test.tgz was created successfully.');
          });

        it('returns status 200', function (done) {
            superrequest.post('/upload')
            .set('Authorization', auth)
            .field('Content-Type', 'multipart/form-data')
            .attach('diag', 'app/diags/test.tgz')
            .end(function (error, response, body) {
                if (error) {
                    console.log(error);
                } else expect(response.status).to.equal(200);
                done();
            });
        });

    });

    describe('List Files Test', function () {

        let url = 'http://localhost:8000/files';

        it('returnts status 200', function (done) {
            request.get({
                url: url,
                headers: headers
            }, function (error, response, body) {
                expect(response.body).to.include('test.tgz');
                done();
            });
        });

    });

    describe('Download File Test', function () {

        let url = 'http://localhost:8000/download/test.tgz';

        it('returnts status 200', function (done) {
            request.get({
                url: url,
                headers: headers
            }, function (error, response, body) {
                expect(response.statusCode).to.equal(200);
                done();
            });
        });

    });

});