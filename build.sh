#!/bin/bash

cleanUp() {
  rm -rf Python-App
 
  # Remove dangling images left-over from build
  if [[ `docker images -q --filter "dangling=true"` ]]
  then
    echo
    echo "Deleting intermediate containers..."
    docker images -q --filter "dangling=true" | xargs docker rmi;
  fi
}
trap cleanUp EXIT

cp runMachineAgent.sh Java-App/
cp runMachineAgent.sh PHP-App/
cp runMachineAgent.sh Node-App/
cp runMachineAgent.sh python-siege/

cp MachineAgent.zip Java-App/
cp MachineAgent.zip PHP-App/
cp MachineAgent.zip Node-App/
cp MachineAgent.zip python-siege/

echo; echo "Building MixApp containers"

echo; echo "Building Python App: "
(git clone https://github.com/Appdynamics/Python-Demo-App.git Python-App)
(cp -rf python-siege Python-App/Docker/)

echo; echo "Building Python Postgres Database..." 
(cd Python-App/Docker/python-postgresql && docker build -t appdynamics/python-postgresql .)

echo; echo "Building Python MySQL Database..." 
(cd Python-App/Docker/python-mysql && docker build -t appdynamics/python-mysql .)

echo; echo "Building Python App..." 
(cd Python-App/Docker/python-app && docker build -t appdynamics/python-app .)

echo; echo "Building Siege Load Generator..." 
(cd Python-App/Docker/python-siege && docker build -t appdynamics/python-siege .)

echo; echo "Building PHP App..."
(cd PHP-App && docker build -t appdynamics/php-app .)

echo; echo "Building Node App..." 
(cd Node-App && docker build -t appdynamics/nodejs-app .)

cp AppServerAgent.zip Java-App/

echo "Building the Java App Container..."
(cd Java-App && docker build -t appdynamics/java-app .)
