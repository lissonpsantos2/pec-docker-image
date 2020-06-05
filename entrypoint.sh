#!/bin/bash

mkdir -p /var/lock/subsys/e-SUS-AB-PostgreSQL
service e-SUS-AB-PostgreSQL restart
service e-SUS-AB-PostgreSQL start
sh /opt/e-SUS/jboss-as-7.2.0.Final/bin/init.d/jboss-as-standalone-lsb.sh restart
sh /opt/e-SUS/jboss-as-7.2.0.Final/bin/init.d/jboss-as-standalone-lsb.sh start

tail -f /opt/e-SUS/jboss-as-7.2.0.Final/standalone/log/boot.log
