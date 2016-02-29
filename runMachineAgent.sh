#!/bin/bash

source /env.sh

cd /machine-agent

nohup java ${MACHINE_AGENT_JAVA_OPTS} -jar machineagent.jar > machine-agent.out 2>&1 &
