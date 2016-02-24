#!/bin/bash

if [ -z "${EXTERNAL}" ]; then
        export EXTERNAL="http://www.appdynamics.com";
fi

if [ -z "${PROCUREMENT_URL}" ]; then
        export PROCUREMENT_URL="http://www.amazon.com";
fi
