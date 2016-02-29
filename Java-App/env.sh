#!/bin/bash

if [ -z "${APP_NAME}" ]; then
        export APP_NAME="MixApp";
fi

if [ -z "${CONTROLLER}" ]; then
        export CONTROLLER="controller";
fi

if [ -z "${APPD_PORT}" ]; then
        export APPD_PORT=8090;
fi

if [ -z "${ACCOUNT_NAME}" ]; then
        export ACCOUNT_NAME="customer1";
fi

if [ -z "${ACCESS_KEY}" ]; then
        export ACCESS_KEY="your-account-access-key";
fi

if [ -z "${JAVA_NODE_NAME}" ]; then
	export JAVA_NODE_NAME="Java-Node";
fi

if [ -z "${JAVA_TIER_NAME}" ]; then
	export JAVA_TIER_NAME="Java-Tier";
fi

# Set in Dockerfile based on installed App Server Agent version: _VERSION_STRING will be replaced during build
export VERSION_STRING="_VERSION_STRING"

export JAVA_OPTS="-Xmx512m -XX:MaxPermSize=256m"
export APPD_JAVA_OPTS="-Dappdynamics.controller.hostName=${CONTROLLER} -Dappdynamics.controller.port=${APPD_PORT} -Dappdynamics.agent.applicationName=${APP_NAME} -Dappdynamics.agent.tierName=${JAVA_TIER_NAME} -Dappdynamics.agent.nodeName=${JAVA_NODE_NAME} -Dappdynamics.agent.accountName=${ACCOUNT_NAME} -Dappdynamics.agent.accountAccessKey=${ACCESS_KEY}";
export APP_AGENT_JAVA_OPTS="${JAVA_OPTS} ${APPD_JAVA_OPTS} -DjvmRoute=${JVM_ROUTE} -Djava.util.logging.manager=org.apache.juli.ClassLoaderLogManager";
export MACHINE_AGENT_JAVA_OPTS="-Dappdynamics.sim.enabled=true ${JAVA_OPTS} ${APPD_JAVA_OPTS}"
export JMX_OPTS="-Dcom.sun.management.jmxremote.port=8888  -Dcom.sun.management.jmxremote.authenticate=false -Dcom.sun.management.jmxremote.ssl=false"
