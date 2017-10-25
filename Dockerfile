FROM centos:7.4.1708
MAINTAINER gmchoi <cuiguangmin@gmail.com>

RUN sed -i.bak 's/tsflags=nodocs/#&/' /etc/yum.conf \
 && yum -y upgrade \
 && yum -y install man-db \
 && yum -y install man-pages \
 && yum -y groupinstall "Development Tools" \
 && yum -y install vim \
 && yum -y install git \
 && yum -y install subversion

RUN yum -y install epel-release \
 && yum -y install python34 \
 && yum -y install python34-numpy

RUN yum -y install openssh-server \
 && yum -y install sudo \
 && yum -y install wget \
 && yum -y install telnet \
 && yum -y install net-tools \
 && groupadd -g 700 developer \
 && useradd --uid 701 --gid 700 gmchoi \
 && echo "gmchoi:gmchoi" | chpasswd \
 && ssh-keygen -t rsa -N "" -f /etc/ssh/ssh_host_rsa_key \
 && ssh-keygen -t ecdsa -N "" -f /etc/ssh/ssh_host_ecdsa_key \
 && ssh-keygen -t ed25519 -N "" -f /etc/ssh/ssh_host_ed25519_key \
 && echo "gmchoi     ALL=(ALL)       ALL" >> /etc/sudoers

RUN localedef -c -f EUC-KR -i ko_KR ko_KR.euckr \
 && localedef -c -f UTF-8 -i ko_KR ko_KR.utf8

EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]
