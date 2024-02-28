apt-get update
apt install ifupdown -y
apt install traceroute -y
touch /etc/iptables_rules.ipv4
cp /vagrant/inetRouter2/inetRouter2_iptables /etc/network/if-up.d/iptables
chmod +x /etc/network/if-up.d/iptables
echo "net.ipv4.conf.all.forwarding = 1" >> /etc/sysctl.conf
sysctl -p
iptables -t nat -A PREROUTING -p tcp --dport 8080 -j DNAT --to-destination 192.168.0.2
iptables -t nat -A POSTROUTING -p tcp --dport 8080 -j SNAT --to-source 192.168.0.34
iptables-save > /etc/iptables_rules.ipv4

