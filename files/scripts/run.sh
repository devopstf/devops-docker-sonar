#!/bin/bash

set -e

touch /opt/sonarqube/temp/README.txt
chmod 777 /opt/sonarqube/temp/README.txt

if [ "${1:0:1}" != '-' ]; then
  exec "$@"
fi

exec java -jar /opt/sonarqube/lib/sonar-application-$SONAR_VERSION.jar \
  -Dsonar.log.console=true \
  -Dsonar.jdbc.username="$SONARQUBE_JDBC_USERNAME" \
  -Dsonar.jdbc.password="$SONARQUBE_JDBC_PASSWORD" \
  -Dsonar.jdbc.url="$SONARQUBE_JDBC_URL" \
  -Dsonar.web.javaAdditionalOpts="$SONARQUBE_WEB_JVM_OPTS -Djava.security.egd=file:/dev/./urandom" \
  "$@"