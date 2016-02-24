#!/bin/bash
if [ -z "${APP_NAME}" ]; then
        export APP_NAME="PHP-App";
fi

if [ -z "${PHP_TIER_NAME}" ]; then
        export PHP_TIER_NAME="PHP-Tier";
fi

if [ -z "${PHP_NODE_NAME}" ]; then
        export PHP_NODE_NAME="PHP-Node";
fi

if [ -z "${SERVICE_URL}" ]; then
        export SERVICE_URL="www.appdynamics.com";
fi