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
        rsyslog \
        jython && \
    rm -rf /var/cache/apt/archives/* /var/lib/apt/lists/*

# Apache2 modules
RUN a2enmod proxy_http headers ssl

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

# Jetty
RUN cd tmp && \
    curl -#L http://central.maven.org/maven2/org/eclipse/jetty/jetty-distribution/9.3.15.v20161220/jetty-distribution-9.3.15.v20161220.tar.gz | tar -xzf- && \
    mv -v jetty-distribution-* /opt/jetty

# Python pip dependencies
RUN pip install pyDes

# Get gluu dist files
RUN oxVersion=3.0.0-SNAPSHOT && \
    tag=20170109 && \
    mkdir -p /opt/dist/gluu /opt/dist/app /opt/dist/symas && \
    cd /opt/dist/gluu && \
    wget -O oxauth.war http://ox.gluu.org/maven/org/xdi/oxauth-server/${oxVersion}/oxauth-server-${oxVersion}.war?$tag && \
    wget -O identity.war http://ox.gluu.org/maven/org/xdi/oxtrust-server/${oxVersion}/oxtrust-server-${oxVersion}.war?$tag && \
    wget -O cas.war http://ox.gluu.org/maven/org/xdi/ox-cas-server-webapp/${oxVersion}/ox-cas-server-webapp-${oxVersion}.war?$tag

RUN CE_SETUP_TAR=https://github.com/GluuFederation/community-edition-setup/archive/master.tar.gz && \
    cd /tmp && \
    curl -#L ${CE_SETUP_TAR} | tar -xzf- && \
    mv community-edition-setup-master /install

# Disable service commands
RUN cp /bin/true /usr/sbin/service

# Link installed packages to locations where Gluu expects to
RUN ln -sfv /usr/lib/jvm/java-8-openjdk-* /opt/jre && \
    ln -sfv /usr/share/jython/ /opt/jython && \
    ln -sfv /usr/share/jetty9 /opt/jetty

# Export Data Volumes
VOLUME ["/opt/gluu/data","/opt/gluu/schema","/etc/gluu","/etc/certs","/install/output","/var/ox"]

# Run Initial Setup script so that everything is pre-configurated
COPY bin/gluu_setup /bin/gluu_setup
RUN gluu_setup -n || :

# Entrypoint
ENTRYPOINT ["gluu_entrypoint"]

# Copy etc
COPY etc/* /etc/

# Copy Util Scripts
COPY bin/* /bin/
