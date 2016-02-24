#!/bin/bash

# This is a starup script for the Node app

# Set Environment variables
source env.sh && sed -i "s/CONTROLLER/${CONTROLLER}/g" /node-todo/server.js
source env.sh && sed -i "s/APPD_PORT/${APPD_PORT}/g" /node-todo/server.js
source env.sh && sed -i "s/SSL/${SSL}/g" /node-todo/server.js
source env.sh && sed -i "s/ACCOUNT_NAME/${ACCOUNT_NAME}/g" /node-todo/server.js
source env.sh && sed -i "s/ACCESS_KEY/${ACCESS_KEY}/g" /node-todo/server.js
source env.sh && sed -i "s/APP_NAME/${APP_NAME}/g" /node-todo/server.js
source env.sh && sed -i "s/TIER_NAME/${TIER_NAME}/g" /node-todo/server.js
source env.sh && sed -i "s/NODE_NAME/${NODE_NAME}/g" /node-todo/server.js

# Start MongoDB
service mongod start

# Start node App
node node-todo/server.js > nohup-todo.txt