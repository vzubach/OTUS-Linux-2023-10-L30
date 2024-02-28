# -*- mode: ruby -*-
# vi: set ft=ruby : vsa

Vagrant.configure(2) do |config| 
 config.vm.box = "hashicorp/bionic64"
 config.vm.box_version = "1.0.282"
 config.vm.provider "virtualbox" do |v| 
  v.memory = 512 
  v.cpus = 1 
 end 
 config.vm.define "inetRouter" do |inetRouter| 
  inetRouter.vm.network "private_network", ip: "192.168.255.1",  netmask: "255.255.255.252",  virtualbox__intnet: "router-net" 
  #inetRouter.vm.network "private_network", ip: "192.168.56.10",  name: "vboxnet0"
  inetRouter.vm.hostname = "inetRouter" 
  inetRouter.vm.provision "shell", path: "inetRouter/inetRouter.sh"
  inetRouter.vm.provision "shell", run: "always", inline: <<-SHELL
     cp /vagrant/inetRouter/50-vagrant.yaml /etc/netplan/50-vagrant.yaml
     netplan apply
   SHELL
 end 
 config.vm.define "inetRouter2" do |inetRouter2| 
  #inetRouter2.vm.network "private_network", type: "dhcp"
  inetRouter2.vm.network "private_network", ip: "192.168.56.10",  name: "vboxnet0"
  inetRouter2.vm.network "private_network", ip: "192.168.0.34",  netmask: "255.255.255.240",  virtualbox__intnet: "hw-net"
  inetRouter2.vm.hostname = "inetRouter2" 
  inetRouter2.vm.provision "shell", path: "inetRouter2/inetRouter2.sh"
  inetRouter2.vm.provision "shell", run: "always", inline: <<-SHELL
     cp /vagrant/inetRouter2/50-vagrant.yaml /etc/netplan/50-vagrant.yaml
     netplan apply
   SHELL
 end 
 config.vm.define "centralRouter" do |centralRouter| 
  centralRouter.vm.network "private_network", ip: "192.168.255.2",  netmask: "255.255.255.252", virtualbox__intnet: "router-net" 
  centralRouter.vm.network "private_network", ip: "192.168.0.1",  netmask: "255.255.255.240",  virtualbox__intnet: "dir-net"
  centralRouter.vm.network "private_network", ip: "192.168.0.33",  netmask: "255.255.255.240",  virtualbox__intnet: "hw-net"
  centralRouter.vm.network "private_network", ip: "192.168.0.65",  netmask: "255.255.255.192",  virtualbox__intnet: "mgt-net"
  centralRouter.vm.network "private_network", ip: "192.168.255.9",  netmask: "255.255.255.252",  virtualbox__intnet: "office1-central"
  centralRouter.vm.network "private_network", ip: "192.168.255.5",  netmask: "255.255.255.252",  virtualbox__intnet: "office2-central"
  centralRouter.vm.hostname = "centralRouter"
  centralRouter.vm.provision "shell", path: "centralRouter/centralRouter.sh"
  centralRouter.vm.provision "shell", run: "always", inline: <<-SHELL
     cp /vagrant/centralRouter/50-vagrant.yaml /etc/netplan/50-vagrant.yaml
     netplan apply
   SHELL
 end 
 config.vm.define "centralServer" do |centralServer| 
  centralServer.vm.network "private_network", ip: "192.168.0.2",  netmask: "255.255.255.240",  virtualbox__intnet: "dir-net" 
  centralServer.vm.hostname = "centralServer"
  centralServer.vm.provision "shell", path: "centralServer/centralServer.sh"
  centralServer.vm.provision "shell", run: "always", inline: <<-SHELL
     cp /vagrant/centralServer/50-vagrant.yaml /etc/netplan/50-vagrant.yaml
     netplan apply
   SHELL
 end 
# config.vm.define "office1Router" do |office1Router| 
#  office1Router.vm.network "private_network", ip: "192.168.255.10",  netmask: "255.255.255.252",  virtualbox__intnet: "office1-central" 
#  office1Router.vm.network "private_network", ip: "192.168.2.1",  netmask: "255.255.255.192",  virtualbox__intnet: "dev1-net"
#  office1Router.vm.network "private_network", ip: "192.168.2.65",  netmask: "255.255.255.192",  virtualbox__intnet: "test1-net"
#  office1Router.vm.network "private_network", ip: "192.168.2.129",  netmask: "255.255.255.192",  virtualbox__intnet: "managers-net"
#  office1Router.vm.network "private_network", ip: "192.168.2.193",  netmask: "255.255.255.192",  virtualbox__intnet: "office1-net"
#  office1Router.vm.hostname = "office1Router"
#  office1Router.vm.provision "shell", path: "office1Router/office1Router.sh"
#  office1Router.vm.provision "shell", run: "always", inline: <<-SHELL
#     cp /vagrant/office1Router/50-vagrant.yaml /etc/netplan/50-vagrant.yaml
#     netplan apply
#   SHELL
# end 
# config.vm.define "office1Server" do |office1Server| 
#  office1Server.vm.network "private_network", ip: "192.168.2.130",  netmask: "255.255.255.192",  virtualbox__intnet: "managers-net" 
#  office1Server.vm.hostname = "office1Server"
#  office1Server.vm.provision "shell", path: "office1Server/office1Server.sh"
#  office1Server.vm.provision "shell", run: "always", inline: <<-SHELL
#     cp /vagrant/office1Server/50-vagrant.yaml /etc/netplan/50-vagrant.yaml
#     netplan apply
#   SHELL
# end
# config.vm.define "office2Router" do |office2Router| 
#  office2Router.vm.network "private_network", ip: "192.168.255.6",  netmask: "255.255.255.252",  virtualbox__intnet: "office2-central" 
#  office2Router.vm.network "private_network", ip: "192.168.1.1",  netmask: "255.255.255.128",  virtualbox__intnet: "dev2-net"
#  office2Router.vm.network "private_network", ip: "192.168.1.129",  netmask: "255.255.255.192",  virtualbox__intnet: "test2-net"
#  office2Router.vm.network "private_network", ip: "192.168.1.193",  netmask: "255.255.255.192",  virtualbox__intnet: "office2-net"
#  office2Router.vm.hostname = "office2Router"
#  office2Router.vm.provision "shell", path: "office2Router/office2Router.sh"
#  office2Router.vm.provision "shell", run: "always", inline: <<-SHELL
#     cp /vagrant/office2Router/50-vagrant.yaml /etc/netplan/50-vagrant.yaml
#     netplan apply
#   SHELL
# end
# config.vm.define "office2Server" do |office2Server| 
#  office2Server.vm.network "private_network", ip: "192.168.1.2",  netmask: "255.255.255.128",  virtualbox__intnet: "dev2-net" 
#  office2Server.vm.hostname = "office2Server"
#  office2Server.vm.provision "shell", path: "office2Server/office2Server.sh"
#  office2Server.vm.provision "shell", run: "always", inline: <<-SHELL
#     cp /vagrant/office2Server/50-vagrant.yaml /etc/netplan/50-vagrant.yaml
#     netplan apply
#   SHELL
# end 
#end

  # config.vm.provision "shell", inline: <<-SHELL
  #   apt-get update
  #   apt-get install -y apache2
  # SHELL
#end
end