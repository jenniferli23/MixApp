var request = require('request');

exports.crossApp = function(req, res) {
    //Lets configure and request
    request
        .get("http://php_app:80/info.php")
        .on('response', function(response) {
            res.send(response);
            console.log(response.statusCode)
        })
        .on('error', function(err) {
            console.log(err)
    })
};