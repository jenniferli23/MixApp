FROM centos:centos6

MAINTAINER Jennifer Li (jennifer.li@appdynamics.com)

# Enable EPEL for Node.js
RUN rpm -Uvh http://download.fedoraproject.org/pub/epel/6/i386/epel-release-6-8.noarch.rpm

# Install npm
RUN yum install -y npm --enablerepo=epel
RUN npm config set registry http://registry.npmjs.org/
RUN yum install -y vim
RUN yum install -y git
RUN yum install -y unzip
RUN yum -y install java-1.7.0-openjdk-devel

# Add app source
RUN mkdir /node-todo
ADD /node-todo /node-todo

# Install app dependencies

RUN cd /node-todo && npm install appdynamics@next
RUN cd /node-todo && npm install express
RUN cd /node-todo && npm install request
RUN cd /node-todo && npm install mongodb
RUN cd /node-todo && npm install mongoose
RUN cd /node-todo && npm install socket.io

# Machine Agent
ADD MachineAgent.zip /
RUN unzip -q /MachineAgent.zip -d /machine-agent;rm MachineAgent.zip

ADD runMachineAgent.sh /
RUN chmod +x /runMachineAgent.sh

# Install and start mongo
ADD /mongodb-org-3.0.repo /etc/yum.repos.d/
RUN yum install -y mongodb-org

# Set envrironment variable
COPY /env.sh /
RUN chmod 777 /env.sh
COPY /start.sh /
RUN chmod 777 /start.sh

# Expose Ports
EXPOSE  3000

# Set environment variable and start the App
CMD /start.sh 
