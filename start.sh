yum -y install squid
curl -o /etc/squid/squid.conf https://raw.githubusercontent.com/y-fukumoto/proxy/main/squid.conf
IP_ADDRESS=$1
PORT_NUMBER=$2
sed -i s/access_source/$IP_ADDRESS/ /etc/squid/squid.conf
sed -i s/3128/$PORT_NUMBER/ /etc/squid/squid.conf
systemctl start squid
systemctl start firewalld
firewall-cmd --zone=public --add-port=$PORT_NUMBER/tcp --permanent
firewall-cmd --reload