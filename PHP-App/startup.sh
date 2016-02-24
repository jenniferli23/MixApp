#!/bin/bash

# Set Controller variables
source /appdynamics/env.sh && sed -i 's/SERVICE_URL/${SERVICE_URL}/g' catalog.php

# Complete App Agent config
./var/www/appdynamics-php-agent/install.sh -a=${ACCOUNT_NAME}@${ACCESS_KEY} ${CONTROLLER} ${APPD_PORT} ${APP_NAME} ${PHP_TIER_NAME} ${PHP_NODE_NAME}

# Retart Apache Server
apachectl restart

touch /usr/local/bin/error_log
tail -f /usr/local/bin/error_log