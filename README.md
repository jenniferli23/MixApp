Partner Portal App
==================

Jennifer Li

This app is composed by a Python tier, a Node.js tier and a PHP tier. It links to a .Net tier and ECommerce App.

## Prerequisite:

- To build ECommerce App, download App Server Agent, DB Agent, Web Server Agent, Machine Agent and Javascript Agent
- To build PHP tier, download PHP agent (name it: appdynamics-php-agent-x64-linux-tar-self-service.zip) and put into PHP-App folder
- To change Node.js agent version, modify line 20 and give desired version:
```
	RUN cd /nodecellar && npm install appdynamics@4.1.0
```
- Add environment variable to env.sh

## Dependency

ECommerce App need to run first. Then Node.js and PHP tier. Last is Python tier.

## Build

- To build all docker images (ECommerce App, Node.js, PHP and Python), run below command then follow instruction to give agents path:
```
./build.sh
```

- To build only Partner Portal tiers (Node.js, PHP and Python), run:
```
./buildPP.sh
```

## Run

- To run ECommerce App:
```
./startECommerce.sh <tag_name> <App_Name>
```

- To run Partner Portal App:
```
./startPP.sh <tag_name> <App_Name>
```

# MixApp
