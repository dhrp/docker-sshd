# sshd container. Usefull when you want to give someone secure, 
# but uncomplicated access to a folder on your filesystem or 
# something similar.
#
# This container will allow you to set a password at build time 
# with --build-arg password=<secret> 
# And then just let you use the root user to access it.

FROM      ubuntu:14.04
MAINTAINER Thatcher R. Peskens "thatcher@koffiedik.com"

RUN apt-get update \
  && apt-get -y install openssh-server \
  && rm -rf /var/lib/apt/lists/*

RUN mkdir /var/run/sshd 

ARG password
RUN sh -c "echo root:${password:-somepasswordthatyoushouldratherchange} |chpasswd"

RUN sed -i '/PermitRootLogin/c\PermitRootLogin yes' /etc/ssh/sshd_config

EXPOSE 22
CMD    /usr/sbin/sshd -D
