var request = require('request');

module.exports = function (http){
    request.get(
        "http://www.appdynamics.com",
        function (error, response, body) {
             if (!error && response.statusCode == 200) {
                    
                    console.log("SUCCESS");
            }
        }
    )
};