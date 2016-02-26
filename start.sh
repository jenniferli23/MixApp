#!/bin/bash

# Set variables
source env.sh

# Docker container version
if [ -z "$1" ]; then
        export VERSION="latest";
else
        export VERSION=$1;
fi
echo "Using version: $VERSION"

# Default application name
if [ -z "$2" ]; then
        export APP_NAME="MixApp";
else
        export APP_NAME=$2;
fi
echo "Application Name: $APP_NAME"

cleanUp() {
  # Remove dangling images left-over from build
  if [[ `docker images -q --filter "dangling=true"` ]]
  then
    echo "Deleting intermediate containers..."
    docker images -q --filter "dangling=true" | xargs docker rmi;
  fi
}
trap cleanUp EXIT

echo "Starting PHP app"
docker run -d --name php_app \
	-e ACCOUNT_NAME=${ACCOUNT_NAME} -e ACCESS_KEY=${ACCESS_KEY} -e SSL=${SSL} \
	-e APP_NAME=${APP_NAME} -e PHP_TIER_NAME=${PHP_TIER_NAME} -e PHP_NODE_NAME=${PHP_NODE_NAME} \
	-e CONTROLLER=${CONTR_HOST} -e APPD_PORT=${CONTR_PORT} -e SERVICE_URL=${SERVICE_URL} \
	-p 80:80 appdynamics/php-app:latest

echo "Starting Node.js app"
docker run -d --name nodejs_app \
	-e ACCOUNT_NAME=${ACCOUNT_NAME} -e ACCESS_KEY=${ACCESS_KEY} -e SSL=${SSL} \
	-e CONTROLLER=${CONTR_HOST} -e APPD_PORT=${CONTR_PORT} \
	-e APP_NAME=${APP_NAME} -e TIER_NAME=${NODE_TIER_NAME} -e NODE_NAME=${NODE_NODE_NAME} \
	--link php_app:php_app \
    -p 3000:3000 appdynamics/nodejs-app:latest

echo "Starting Python app"
echo -n "python_mysql: "; docker run -d --name python_mysql appdynamics/python-mysql:latest
echo -n "python_postgresql: "; docker run -d --name python_postgresql appdynamics/python-postgresql:latest
sleep 10

echo -n "python_app: "; docker run -d --name python_app \
	-e ACCOUNT_NAME=${ACCOUNT_NAME} -e ACCESS_KEY=${ACCESS_KEY} -e SSL=${SSL}\
	-e CONTROLLER=${CONTR_HOST} -e APPD_PORT=${CONTR_PORT} \
	-e APP_NAME=${APP_NAME} -e TIER_NAME=${PY_TIER_NAME} -e NODE_NAME=${PY_NODE_NAME} \
	--link python_mysql:python_mysql --link python_postgresql:python_postgresql \
	--link php_app:php_app --link nodejs_app:nodejs_app -p 9000:9000 appdynamics/python-app:latest

#echo -n "python_siege: "; docker run -d --name python_siege -e BUNDY_TIER=${SIEGE_URL} -e PROCUREMENT_URL=${PROCUREMENT_URL}\
#	--link python_app:python_app appdynamics/python-siege:latest

echo -n "Starting java_app"; docker run -d --name java_app -p 8080:8080 \
        -e ACCOUNT_NAME=${ACCOUNT_NAME} -e ACCESS_KEY=${ACCESS_KEY} -e SSL=${SSL} \
        -e APP_NAME=${PP_APP_NAME} -e JAVA_TIER_NAME=${JAVA_TIER_NAME} -e JAVA_NODE_NAME=${JAVA_NODE_NAME} \
        -e CONTROLLER=${CONTR_HOST} -e APPD_PORT=${CONTR_PORT} \
        appdynamics/java-app:${VERSION}

exit 0
