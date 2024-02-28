apt-get update
apt install knockd -y
apt install ifupdown -y
apt install traceroute -y
touch /etc/iptables_rules.ipv4
cp /vagrant/inetRouter/inetRouter_iptables /etc/network/if-up.d/iptables
cp /vagrant/inetRouter/knockd /etc/default/knockd
cp /vagrant/inetRouter/knockd.conf /etc/knockd.conf
cp /vagrant/inetRouter/knockd.srv /etc/systemd/system/knockd.service
chmod +x /etc/network/if-up.d/iptables
iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE
iptables -A INPUT -i eth1 -p icmp -j ACCEPT
iptables -A INPUT -i eth1 -m state --state RELATED,ESTABLISHED -j ACCEPT
iptables -A INPUT -i eth1 -j DROP
iptables -A INPUT -i eth0 -j ACCEPT
iptables-save > /etc/iptables_rules.ipv4
echo "net.ipv4.conf.all.forwarding = 1" >> /etc/sysctl.conf
sysctl -p
systemctl daemon-reload
systemctl enable knockd
systemctl restart knockd



