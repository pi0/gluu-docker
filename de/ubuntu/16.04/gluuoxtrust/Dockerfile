FROM quay.io/gluu/base

# MAINTAINER Pooya Parsa <pooya@pi0.ir>

# Install oxTrust
RUN mkdir -p /var/ox/photos /var/ox/oxtrust/removed /var/ox/oxtrust/vds-snapshots && \
    mkdir -p /var/gluu/webapps/oxtrust \
    mkdir -p /var/gluu/webapps/oxtrust/pages && \
    mkdir -p /var/gluu/webapps/oxtrust/resources && \
    mkdir -p /var/gluu/webapps/oxtrust/libs && \
    mkdir -p /opt/tomcat/webapps/identity/WEB-INF/lib/Lib && \
    ln -sf /opt/jython/Lib /opt/tomcat/webapps/identity/WEB-INF/lib/Lib

RUN OXTRUST_DOWNLOAD_URL=https://ox.gluu.org/maven/org/xdi/oxtrust-server/${OX_VERSION}/oxtrust-server-${OX_VERSION}.war && \
    curl -#L ${OXTRUST_DOWNLOAD_URL} > /tmp/oxtrust.war && \
    unzip -qq /tmp/oxtrust.war -d /opt/tomcat/webapps/identity && \
    rm -f /tmp/oxtrust.war && \
    unzip -q /opt/tomcat/webapps/identity/WEB-INF/lib/oxtrust-configuration-${OX_VERSION}.jar shibboleth2/* -d /opt/tomcat/conf 

# Copy static templates
COPY conf/setenv.sh /opt/tomcat/bin
COPY conf/attribute-resolver.xml.vm /opt/tomcat/conf/shibboleth2/idp
COPY conf/oxTrustLogRotationConfiguration.xml /opt/tomcat/conf
COPY conf/identity.xml /opt/tomcat/conf/Catalina/localhost
COPY conf/index.html /opt/tomcat/webapps/ROOT
