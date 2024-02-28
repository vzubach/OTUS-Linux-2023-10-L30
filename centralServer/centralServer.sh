apt-get update
apt install ifupdown -y
apt install nginx -y
touch /etc/iptables_rules.ipv4
cp /vagrant/inetRouter2/inetRouter2_iptables /etc/network/if-up.d/iptables
chmod +x /etc/network/if-up.d/iptables
echo "net.ipv4.conf.all.forwarding = 1" >> /etc/sysctl.conf
sysctl -p
iptables -t nat -A PREROUTING -p tcp --dport 8080 -j REDIRECT --to-ports 80
iptables-save > /etc/iptables_rules.ipv4


