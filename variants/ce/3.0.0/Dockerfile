FROM ubuntu:14.04

# MAINTAINER pooya parsa <pooya@pi0.ir>

# dpkg no interactive mode
ENV DEBIAN_FRONTEND noninteractive

RUN GLUU_VER=3.0.0 && \ 
    apt-get update && \
    apt-get install -y curl vim rsync apt-transport-https && \
    echo "deb https://repo.gluu.org/ubuntu/ trusty-devel main" > /etc/apt/sources.list.d/gluu-repo.list && \
    curl https://repo.gluu.org/ubuntu/gluu-apt.key | apt-key add - && \
    apt-get update && \
    apt-get install gluu-server-3.0.0 -fy && \
    cd /opt/gluu-server-${GLUU_VER} && \
    rm -r sys etc/hosts etc/resolv.conf etc/hostname dev && \
    rsync -aSAX --numeric-ids * / && \
    cd / && \
    sed -i 's/mirrors.digitalocean.com/archive.ubuntu.com/g' /etc/apt/sources.list && \
    apt-get update --allow-unauthenticated && \
    yes | apt-get upgrade -f && \
    rm -rf /opt/gluu-server-${GLUU_VER} /var/cache/apt/archives/* /var/lib/apt/lists/*

# Init script
CMD gluu_init

# Volumes
VOLUME ["/opt/opendj/db"]

# Export Ports
EXPOSE 80 443 

# Copy etc
COPY etc/* /etc/

# Copy bin
COPY bin/* /bin/
