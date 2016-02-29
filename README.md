#MixApp
==================

## Prerequisite:

- To build MixApp download App Server Agent, DB Agent, Web Server Agent, Machine Agent and Javascript Agent
- To build PHP tier, download PHP agent (name it: appdynamics-php-agent-x64-linux-tar-self-service.zip) and put into PHP-App folder
- To change Node.js agent version, modify line 20 and give desired version:
```
	RUN cd /node-todo && npm install appdynamics@4.1.0
```
- Add environment variable to env.sh

## Dependency

PHP Tier needs to run first. Then Node.js app. Last is Python app.

## Build

- To build all docker images (Node.js, PHP and Python), run below command then follow instruction to give agents path:
```
./build.sh
```

## Run

- To run MixApp:
```
./start.sh <tag_name> <App_Name>
```

## Load

- To generate load(Load is generated using a java file so it require >= jdk1.7 installed in the host machine):
```
./runLoad.sh
