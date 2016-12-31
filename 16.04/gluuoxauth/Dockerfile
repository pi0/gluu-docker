FROM quay.io/gluu/base

# MAINTAINER Pooya Parsa <pooya@pi0.ir>

# Install oxAuth
RUN mkdir -p /var/gluu/webapps/oxauth && \
    mkdir -p /var/gluu/webapps/oxauth/pages && \
    mkdir -p /var/gluu/webapps/oxauth/resources && \
    mkdir -p /var/gluu/webapps/oxauth/libs && \
    mkdir -p /opt/tomcat/webapps/oxauth/WEB-INF/lib/Lib && \
    ln -sf /opt/jython/Lib /opt/tomcat/webapps/oxauth/WEB-INF/lib/Lib

RUN OXAUTH_DOWNLOAD_URL=https://ox.gluu.org/maven/org/xdi/oxauth-server/${OX_VERSION}/oxauth-server-${OX_VERSION}.war && \
    curl -#L ${OXAUTH_DOWNLOAD_URL} > /tmp/oxauth.war && \
    unzip -qq /tmp/oxauth.war -d /opt/tomcat/webapps/oxauth && \
    rm -f /tmp/oxauth.war

# Copy static templates
COPY conf/duo_web.py /opt/tomcat/conf/python
COPY conf/setenv.sh /opt/tomcat/bin
COPY conf/certs /etc/certs
