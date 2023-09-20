FROM centos:7

RUN yum -y install squid
RUN curl -o etc/squid/squid.conf https://raw.githubusercontent.com/y-fukumoto/proxy/main/squid..conf
ARG ip
ARG port
RUN sed -i s/access_source/${ip}/ etc/squid/squid.conf
RUN sed -i s/3128/${port}/ etc/squid/squid.conf
RUN systemctl start squid
RUN systemctl start firewalld
RUN firewall-cmd --zone=public --add-port=${port}/tcp --permanent
RUN firewall-cmd --reload
