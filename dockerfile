FROM centos:7.5

RUN yum -y install squid
RUN curl -o etc/squid/squid.conf https://drive.google.com/file/d/1SNTeO48s6nLGH2VllXQo6ZOR6_FCk1Yg/view?usp=drive_link
ARG ip
ARG port
RUN sed -i s/access_source/${ip}/ etc/squid/squid.conf
RUN sed -i s/3128/${port}/ etc/squid/squid.conf
RUN systemctl start squid
RUN systemctl start firewalld
RUN firewall-cmd --zone=public --add-port=${port}/tcp --permanent
RUN firewall-cmd --reload
