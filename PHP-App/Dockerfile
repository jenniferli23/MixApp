FROM centos:centos6

MAINTAINER Jennifer Li (jennifer.li@appdynamics.com)

# Install resources
# Centos 6 installs Apache 2.2 by default: we want 2.4
RUN yum clean all
RUN yum -y install wget && yum clean all
RUN cd /etc/yum.repos.d/; wget http://repos.fedorapeople.org/repos/jkaluza/httpd24/epel-httpd24.repo
RUN yum -y install httpd24.x86_64
RUN yum -y install php
RUN yum -y install php-cli
RUN yum -y install unzip
RUN yum -y install bzip2
RUN yum -y install tar
RUN yum -y install which
RUN yum -y install curl
RUN yum -y install java-1.7.0-openjdk-devel

# Use Apache Worker MPM
ENV HTTPD_24 /opt/rh/httpd24/root/etc/httpd
ADD 00-mpm.conf ${HTTPD_24}/conf.modules.d/00-mpm.conf

# Add files in place
ADD *.php /var/www/html/

RUN apachectl start

# Environment settings for startup scripts
ADD env.sh /
RUN chmod +x /env.sh

# Install bits and setup install for AppD Agent
ADD appdynamics-php-agent-x64-linux-tar-self-service.zip /var/www/
RUN unzip -o -d /var/www/ /var/www/appdynamics-php-agent-x64-linux-tar-self-service.zip 
RUN tar -xvjf /var/www/appdynamics-php-agent/*.tar.bz2 -C /var/www/
RUN chmod 777 /var/www/appdynamics-php-agent/logs
RUN chmod -R 755 /var/www/appdynamics-php-agent/php

# Machine Agent
ADD MachineAgent.zip /
RUN unzip -q /MachineAgent.zip -d /machine-agent;rm MachineAgent.zip

ADD runMachineAgent.sh /
RUN chmod +x /runMachineAgent.sh

# Add Env script
ADD /env.sh /appdynamics/
RUN chmod 777 /appdynamics/env.sh

# Add startup script
ADD startup.sh /
RUN chmod 777 /startup.sh

# Expose Ports
EXPOSE 80

# Start the app
CMD /startup.sh
