FROM ubuntu:16.04

# MAINTAINER pooya parsa <pooya@pi0.ir>

# dpkg no interactive mode
ENV DEBIAN_FRONTEND noninteractive

# Get dependencies
RUN apt-get update && \
    apt-get install -fy \
        curl \
        wget \
        vim \
        supervisor \
        python2.7 \
        apache2 \
        libapache2-modsecurity \
        libapache2-mod-evasive \
        ca-certificates \
        mysql-common \
        unzip \
        xz-utils \
        openjdk-8-jre-headless \
        jetty9 \
        rsyslog \
        jython && \
    rm -rf /var/cache/apt/archives/* /var/lib/apt/lists/*

# Apache2 modules
RUN a2enmod proxy_http headers ssl

# Install 3rd party dependencies

# Node
RUN curl -sL https://deb.nodesource.com/setup_7.x | bash && \
    apt-get install -fy nodejs && \
    rm -rf /var/cache/apt/archives/* /var/lib/apt/lists/*

# Python pip
RUN curl -sL https://bootstrap.pypa.io/get-pip.py | python

# OpenDJ 
RUN cd tmp && \
    curl -#L https://github.com/OpenRock/OpenDJ/releases/download/3.0.0/OpenDJ-3.0.0.zip > opendj.zip && \
    unzip -n -q opendj.zip -d /opt && \
    rm opendj.zip

# Symas Openldap Gluu
RUN cd tmp && \
    curl -#L http://0up.ir/do.php?downf=symas-openldap-gluu-amd64-2-4-44-20161020-amd64-deb.gz | gunzip > openldap.deb && \
    dpkg -i openldap.deb && \
    rm openldap.deb

# Community-edition-setup

# Prepare
RUN ln -sfv /usr/lib/jvm/java-8-openjdk-* /opt/jre && \
    ln -sfv /usr/share/jython/ /opt/jython && \
    ln -sfv /usr/share/jetty9 /opt/jetty && \
    mkdir -p /opt/dist/gluu /opt/dist/app /opt/dist/symas

RUN CE_SETUP_TAR=https://github.com/GluuFederation/community-edition-setup/archive/master.tar.gz && \
    cd /tmp && \
    curl -#L ${CE_SETUP_TAR} | tar -xzf- && \
    mv community-edition-setup-master /install && \
    pip install pyDes

# Export Data Volumes
VOLUME ["/opt/gluu/data","/opt/gluu/schema","/etc/gluu","/etc/certs","/install/out"]

# Copy Docker Scripts
COPY bin/* /bin/

# Run Initial Setup script so that everything is pre configurated
# This Phase also downloads latest war files
RUN gluu_setup -n -w
