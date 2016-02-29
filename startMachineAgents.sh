#!/bin/bash

echo "Starting machine agent on java_app container..."; docker exec java_app /runMachineAgent.sh; echo "Done"
echo "Starting machine agent on php_app container..."; docker exec php_app /runMachineAgent.sh; echo "Done"
echo "Starting machine agent on python_app container..."; docker exec python_app /runMachineAgent.sh; echo "Done"
echo "Starting machine agent on nodejs_app container..."; docker exec nodejs_app /runMachineAgent.sh; echo "Done"
