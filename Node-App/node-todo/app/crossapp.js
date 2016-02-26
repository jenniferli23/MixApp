var request = require('request');

exports.crossApp = function(req, res) {
    
    request
        .get(req.query.url)
        .on('response', function(response) {
            res.send(response);
            console.log(response.statusCode, 'SUCCESS')
        })
        .on('error', function(err) {
            console.log(err)
    })
};