FROM centos:5.11

RUN rm -f /etc/yum.repos.d/*.repo
RUN sed -i 's/enabled=1/enabled=0/' /etc/yum/pluginconf.d/fastestmirror.conf 

COPY CentOS-Base.repo /etc/yum.repos.d/CentOS-Base.repo
RUN yum install -y gcc xz curl.x86_64

RUN set -eux; \
    curl -s -k https://dl.google.com/go/go1.4.3.linux-amd64.tar.gz |tar zxf -; \
	mv go /usr/local/go1.4.3; 

ENV GOROOT_BOOTSTRAP=/usr/local/go1.4.3/
