FROM centos:centos7

# Visit our organization "devopstf" for more images to come!
LABEL mantainer="odiazdom - devopstf - DevOps Engineering"

ENV SONAR_VERSION=6.2 \
    SONARQUBE_HOME=/opt/sonarqube \
    
    # Database configuration; Default is H2.
    SONARQUBE_JDBC_USERNAME=sonar \
    SONARQUBE_JDBC_PASSWORD=sonar \
    SONARQUBE_JDBC_URL=

# Http port
EXPOSE 9000

RUN groupadd sonar -g 65534 && \
    useradd sonar -u 65500 -g sonar && \
    yum install -y unzip java dos2unix && \
    chmod 777 /opt
    
USER sonar

RUN set -x && \
    cd /opt && \
    curl -o sonarqube.zip -fSL https://sonarsource.bintray.com/Distribution/sonarqube/sonarqube-$SONAR_VERSION.zip && \
    unzip sonarqube.zip && \
    mv sonarqube-$SONAR_VERSION sonarqube && \
    rm sonarqube.zip*

WORKDIR $SONARQUBE_HOME
COPY files/scripts/run.sh $SONARQUBE_HOME/bin/run.sh
COPY files/conf/sonar.properties $SONARQUBE_HOME/conf/sonar.properties

USER root

RUN chmod +x $SONARQUBE_HOME/bin/run.sh

USER sonar

ENTRYPOINT ["/opt/sonarqube/bin/run.sh"]
