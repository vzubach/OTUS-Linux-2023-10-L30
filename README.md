### OTUS-Linux-2023-10-L30 | iptables

**Получение доступа к inetRouter с centralRouter:**  

- iptable со стороны inetRouter - нет открытых портов ssh:

		root@inetRouter:~# iptables -nvL
		Chain INPUT (policy ACCEPT 0 packets, 0 bytes)
		 pkts bytes target     prot opt in     out     source               destination         
		    0     0 ACCEPT     icmp --  eth1   *       0.0.0.0/0            0.0.0.0/0           
		    0     0 ACCEPT     all  --  eth1   *       0.0.0.0/0            0.0.0.0/0            state RELATED,ESTABLISHED
		    8   480 DROP       all  --  eth1   *       0.0.0.0/0            0.0.0.0/0           
		  389 26450 ACCEPT     all  --  eth0   *       0.0.0.0/0            0.0.0.0/0           

- подключаемся по ssh со стороны centralRouter - доступа нет: 

		root@centralRouter:~# ssh -l vagrant 192.168.255.1
		^C
		root@centralRouter:~# 

- стучимся...

		knock 192.168.255.1 7000 9000 8000  

- доступ появляется:  

		root@centralRouter:~# ssh -l vagrant 192.168.255.1
		The authenticity of host '192.168.255.1 (192.168.255.1)' can't be established.
		ECDSA key fingerprint is SHA256:uY6GIjFdI9qTC4QYb980QRk+WblJF9cd5glr3SmmL+w.
		Are you sure you want to continue connecting (yes/no)? 

**Проброс порта**

- Добавлен маршрутизатор inetRouter2 по схеме:  
	> inetRouter2 --> 192.168.0.32/28 --> centralRouter --> 192.168.0.0/28 --> centralServer

- На inetRouter2 в iptables добавляем следующие првила:  
	> iptables -t nat -A PREROUTING -p tcp --dport 8080 -j DNAT --to-destination 192.168.0.2
	> iptables -t nat -A POSTROUTING -p tcp --dport 8080 -j SNAT --to-source 192.168.0.34

- На centralServer поднят nginx на порту 80. В iptables добавляем редирект:
	> iptables -t nat -A PREROUTING -p tcp --dport 8080 -j REDIRECT --to-ports 80

- Пробуем подключиться с хоста на host-only интерфейс inetRouter2 по порту 8080:
	
		falcon@ubuntu-pc:~/OTUS-Linux-2023-10-L30$ telnet 192.168.56.10 8080
		Trying 192.168.56.10...
		Connected to 192.168.56.10.
		Escape character is '^]'.
		get
		HTTP/1.1 400 Bad Request
		Server: nginx/1.14.0 (Ubuntu)
		Date: Wed, 28 Feb 2024 12:28:53 GMT
		Content-Type: text/html
		Content-Length: 182
		Connection: close
		
		<html>
		<head><title>400 Bad Request</title></head>
		<body bgcolor="white">
		<center><h1>400 Bad Request</h1></center>
		<hr><center>nginx/1.14.0 (Ubuntu)</center>
		</body>
		</html>
		Connection closed by foreign host.
		falcon@ubuntu-pc:~/OTUS-Linux-2023-10-L30$

	Попадаем на веб-страницу nginx на centralServer

