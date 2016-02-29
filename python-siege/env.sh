#!/bin/bash

if [ -z "${EXTERNAL}" ]; then
        export EXTERNAL="http://www.appdynamics.com";
fi

if [ -z "${PROCUREMENT_URL}" ]; then
        export PROCUREMENT_URL="http://www.amazon.com";
fi

export JAVA_OPTS="-Xmx512m -XX:MaxPermSize=256m"
export APPD_JAVA_OPTS="-Dappdynamics.controller.hostName=${CONTROLLER} -Dappdynamics.controller.port=${APPD_PORT} -Dappdynamics.agent.applicationName=${APP_NAME} -Dappdynamics.agent.tierName=${PY_TIER_NAME} -Dappdynamics.agent.nodeName=${PY_NODE_NAME} -Dappdynamics.agent.accountName=${ACCOUNT_NAME} -Dappdynamics.agent.accountAccessKey=${ACCESS_KEY}";
export MACHINE_AGENT_JAVA_OPTS="-Dappdynamics.sim.enabled=true ${JAVA_OPTS} ${APPD_JAVA_OPTS}"
