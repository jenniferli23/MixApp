require("appdynamics").profile({
    controllerHostName: 'CONTROLLER',
    controllerPort: 'APPD_PORT', // If SSL, be sure to enable the next line  
    ssl: 'SSL',
    accountName: 'ACCOUNT_NAME', // Required for a controller running in multi-tenant mode
    accountAccessKey: 'ACCESS_KEY', // Required for a controller running in multi-tenant mode
    applicationName: 'APP_NAME',
    tierName: 'TIER_NAME',
    nodeName: 'NODE_NAME' // The controller will automatically append the node name with a unique number
});

// set up ======================================================================
var express = require('express');
var app = express(); 						// create our app w/ express
var mongoose = require('mongoose'); 				// mongoose for mongodb
var port = process.env.PORT || 3000; 				// set the port
var database = require('./config/database'); 			// load the database config
var morgan = require('morgan');
var bodyParser = require('body-parser');
var methodOverride = require('method-override');

// configuration ===============================================================
mongoose.connect(database.localUrl); 	// Connect to local MongoDB instance.

app.use(express.static(__dirname + '/public')); 		// set the static files location /public/img will be /img for users
app.use(morgan('dev')); // log every request to the console
app.use(bodyParser.urlencoded({'extended': 'true'})); // parse application/x-www-form-urlencoded
app.use(bodyParser.json()); // parse application/json
app.use(bodyParser.json({type: 'application/vnd.api+json'})); // parse application/vnd.api+json as json
app.use(methodOverride('X-HTTP-Method-Override')); // override with the X-HTTP-Method-Override header in the request

// routes ======================================================================
require('./app/routes.js')(app);


// listen (start app with node server.js) ======================================
app.listen(port);
console.log("App listening on port " + port);
