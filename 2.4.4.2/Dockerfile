FROM ubuntu:16.04

# MAINTAINER pooya parsa <pooya@pi0.ir>

# dpkg no interactive mode
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && \
    apt-get install -y curl rsync vim && \
    cd /tmp && \
    curl -#L https://repo.gluu.org/ubuntu/pool/main/xenial/gluu-server-2.4.4.2_1-1~xenial+Ub16.04_amd64.deb > gluu.deb && \
    dpkg -x gluu.deb gluu && \
    cd gluu/opt/gluu-server-2.4.4.2 && \
    rm -r sys etc/hosts etc/resolv.conf etc/hostname var/run var/lock tmp && \
    rsync -aSAX * / && \
    rm -rf /tmp/gluu* && \
    sed -i 's/mirrors.digitalocean.com/archive.ubuntu.com/g' /etc/apt/sources.list && \
    apt-get update --allow-unauthenticated && \
    yes | apt-get dist-upgrade -f && \
    rm -rf /var/lib/apt/lists/*

# Entrypoint
CMD gluu_entrypoint

# Volumes
VOLUME ["/opt/opendj/db"]

# Export Ports
EXPOSE 80 443 

# Copy Scripts
COPY bin/* /bin/
