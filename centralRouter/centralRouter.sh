apt-get update
apt install knockd -y
apt install traceroute -y
echo "net.ipv4.conf.all.forwarding = 1" >> /etc/sysctl.conf
sysctl -p



