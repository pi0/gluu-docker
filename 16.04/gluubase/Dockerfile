FROM ubuntu:16.04

# MAINTAINER Pooya parsa <pooya@pi0.ir>

ENV DEBIAN_FRONTEND noninteractive

# Define entrypoint CMD
CMD ["/usr/bin/supervisord"]

# Ports required by apache & tomcat
EXPOSE 80 443 8009 8005

# Install base packages
RUN apt-get update && \
    apt-get install -fy \
        curl \
        wget \
        supervisor \
        vim  \
        unzip \
        apache2 \
        openjdk-8-jre-headless

# Common tasks
RUN groupadd -r tomcat && \
    useradd -r -g tomcat tomcat && \
    mkdir -p /var/log/supervisor && \
    mkdir -p /etc/certs && \
	mkdir -p /opt/tomcat/conf/Catalina/localhost && \
    mkdir -p /opt/tomcat/conf/python

# Install Tomcat
RUN TOMCAT_VERSION=7.0.65 && \
    TOMCAT_DOWNLOAD_URL=http://archive.apache.org/dist/tomcat/tomcat-7/v${TOMCAT_VERSION}/bin/apache-tomcat-${TOMCAT_VERSION}.tar.gz && \
    wget -q ${TOMCAT_DOWNLOAD_URL} -O /tmp/tomcat.tar.gz && \
    tar -xzf /tmp/tomcat.tar.gz -C /opt && \
    mv /opt/apache-tomcat-${TOMCAT_VERSION} /opt/tomcat && \
    rm -f /tmp/tomcat.tar.gz && \
    mkdir -p /opt/tomcat/endorsed && \
    wget -q http://central.maven.org/maven2/org/bouncycastle/bcprov-jdk16/1.46/bcprov-jdk16-1.46.jar -O /opt/tomcat/endorsed/bcprov-jdk16-1.46.jar
 
# Install Jython
RUN JYTHON_VERSION=2.7.0 && \
	JYTHON_DOWNLOAD_URL=http://central.maven.org/maven2/org/python/jython-standalone/${JYTHON_VERSION}/jython-standalone-${JYTHON_VERSION}.jar && \
	wget -q ${JYTHON_DOWNLOAD_URL} -O /tmp/jython.jar && \
    unzip -q /tmp/jython.jar -d /opt/jython && \
    rm -f /tmp/jython.jar

# Install utility scripts
RUN wget -q https://gitcdn.xyz/repo/GluuFederation/gluu-util/master/check_ssl/check_ssl.py -O /usr/bin/check_ssl.py && \
    chmod +x /usr/bin/check_ssl.py

# Set Global version Envs
ENV OX_VERSION 2.4.4.sp1
ENV OX_BUILD_DATE 2016-10-12

# Copy Config files
COPY conf/supervisord.conf /etc/supervisor/conf.d/supervisord.conf
