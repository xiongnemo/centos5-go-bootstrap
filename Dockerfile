FROM centos:5.11 AS base

LABEL maintainer="darren.hoo@gmail.com"

COPY CentOS-Base.repo /tmp
RUN rm -f /etc/yum.repos.d/*.repo; \
    mv /tmp/CentOS-Base.repo /etc/yum.repos.d/; \
    sed -i 's/enabled=1/enabled=0/' /etc/yum/pluginconf.d/fastestmirror.conf; \
    yum install -y gcc xz curl.x86_64 patch

From base AS builder
WORKDIR /root/
COPY go1.17.13-fix.diff /tmp/
RUN set -eux; \
    curl -s -k https://dl.google.com/go/go1.4.3.linux-amd64.tar.gz |tar zxf -; \
    mv go /usr/local/go1.4.3; \
    export GOROOT_BOOTSTRAP=/usr/local/go1.4.3/; \
    curl -s -k https://dl.google.com/go/go1.17.13.src.tar.gz |tar zxf -; \
    cd go; patch -p1 < /tmp/go1.17.13-fix.diff; \
    cd src; ./make.bash

From base 
COPY --from=builder /root/go /usr/local/go1.17.13
ENV GOROOT_BOOTSTRAP=/usr/local/go1.17.13
