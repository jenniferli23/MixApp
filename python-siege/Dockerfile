FROM appdynamics/python-base

MAINTAINER Jeff Morgan (jeff.morgan@appdynamics.com)

################## BEGIN INSTALLATION ######################

RUN apt-get update -y
RUN apt-get install software-properties-common -y
RUN add-apt-repository ppa:webupd8team/java -y
RUN apt-get update -y
RUN echo debconf shared/accepted-oracle-license-v1-1 select true | debconf-set-selections
RUN apt-get install oracle-java8-installer -y
RUN apt-get install oracle-java8-set-default -y

ADD /siege.txt /appd/

# Add startup / env script
ADD /startup.sh /appd/
RUN chmod 777 /appd/startup.sh
ADD /env.sh /appd/
RUN chmod 777 /appd/env.sh

# Machine Agent
ADD MachineAgent.zip /
RUN unzip -q /MachineAgent.zip -d /machine-agent;rm MachineAgent.zip

ADD runMachineAgent.sh /
RUN chmod +x /runMachineAgent.sh

##################### INSTALLATION END #####################

CMD /appd/startup.sh
