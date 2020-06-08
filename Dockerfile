FROM lissonpsantos2/debian-jessie-basic:latest

MAINTAINER Alisson Pereira dos Santos <lissonpsantos2@gmail.com>

#IMAGE VARIABLES
ENV PEC_FOLDER /opt/e-SUS/jboss-as-7.2.0.Final/bin/init.d/jboss-as-standalone-lsb.sh
ENV IMAGE_ALIAS ESUS 3.2.24
ENV PEC_FOLDER mkdir -p /var/lock/subsys/ && service e-SUS-AB-PostgreSQL restart && service e-SUS-AB-PostgreSQL start && sh /opt/e-SUS/jboss-as-7.2.0.Final/bin/init.d/jboss-as-standalone-lsb.sh restart
ENV SEPARATOR -
ENV INFO_IMAGE "To start the PEC3.0 run: sh ${PEC_FOLDER} start"

#CREATE PEC 3.0 FOLDER
RUN mkdir /home/PEC

#SET WORKDIR PEC 3.0 FOLDER
WORKDIR /home/PEC

#UPDATE IMAGE
RUN apt-get update
RUN apt-get upgrade -y

#INSTALL PACKAGES
RUN apt-get install -y openjdk-7-jdk

#PEC INSTALL

RUN wget https://arquivos.esusab.ufsc.br/PEC/eRFeiwzHphMOpiWX/3.2.24/treinamento/instalador/Instalador-eSUS-AB-PEC-3.2.24-Treinamento-Linux.zip -O pec.zip
RUN unzip pec.zip -d /home/PEC/install
WORKDIR /home/PEC/install

#LOCALE PT_BR
RUN curl -o /etc/locale.gen https://raw.githubusercontent.com/lissonpsantos2/pec-docker-image/master/locale #redo

#JAVA.CONF FILE
RUN curl -o /etc/java.conf https://raw.githubusercontent.com/lissonpsantos2/pec-docker-image/master/javaconf #redo

RUN apt-get install -y locales
RUN locale-gen
RUN sh instalador_linux.sh

WORKDIR /

ENTRYPOINT mkdir -p /var/lock/subsys/ && service e-SUS-AB-PostgreSQL restart && service e-SUS-AB-PostgreSQL start && sh /opt/e-SUS/jboss-as-7.2.0.Final/bin/init.d/jboss-as-standalone-lsb.sh start ; /bin/bash
