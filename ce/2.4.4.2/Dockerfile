FROM ubuntu:16.04

# MAINTAINER pooya parsa <pooya@pi0.ir>

# dpkg no interactive mode
ENV DEBIAN_FRONTEND noninteractive

RUN GLUU_VER=2.4.4.2 && \ 
    apt-get update && \
    apt-get install -y curl vim rsync apt-transport-https && \
    echo "deb https://repo.gluu.org/ubuntu/ xenial main" > /etc/apt/sources.list.d/gluu-repo.list && \
    curl https://repo.gluu.org/ubuntu/gluu-apt.key | apt-key add - && \
    apt-get update && \
    apt-get install gluu-server-${GLUU_VER} -fy && \
    cd /opt/gluu-server-${GLUU_VER} && \
    rm -r sys etc/hosts etc/resolv.conf etc/hostname && \
    rsync -aSAX --numeric-ids * / && \
    cd / && \
    sed -i 's/mirrors.digitalocean.com/archive.ubuntu.com/g' /etc/apt/sources.list && \
    apt-get update --allow-unauthenticated && \
    yes | apt-get upgrade -f && \
    rm -rf /opt/gluu-server-${GLUU_VER} /var/cache/apt/archives/* /var/lib/apt/lists/*

# Entrypoint
CMD gluu_entrypoint

# Volumes
VOLUME ["/opt/opendj/db"]

# Export Ports
EXPOSE 80 443 

# Copy etc
COPY etc/* /etc/

# Copy bin
COPY bin/* /bin/
