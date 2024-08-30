#! /bin/bash

# Script to automate installing Virtulbox VM manager and OpenVPN VPN service and to configure both to host
# Micromine License Server

# Update and upgrade the machine after initial install and install common utilities

sudo apt update && upgrade -y
sudo apt install -y neovim ripgrep bpytop curl git firewalld qemu-system libvirt-daemon-system

# Add Oracle repos to /etc/apt/sources.list to pull from repo using apt

cho | sudo tee -a /etc/apt/sources.list
echo | sudo tee -a /etc/apt/sources.list
echo "# Oracle repo for pulling down Virtualbox"| sudo tee -a /etc/apt/sources.list
echo | sudo tee -a /etc/apt/sources.list
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/oracle-virtualbox-2016.gpg] https://download.virtualbox.org/virtualbox/debian bookworm contrib" | sudo tee -a /etc/apt/sources.list
echo | sudo tee -a /etc/apt/sources.list


wget -O- https://www.virtualbox.org/download/oracle_vbox_2016.asc | sudo gpg --yes --output /usr/share/keyrings/oracle-virtualbox-2016.gpg --dearmor

sudo apt-get update -y
sudo apt-get install -y virtualbox-7.0
wget https://download.virtualbox.org/virtualbox/7.0.20/Oracle_VM_VirtualBox_Extension_Pack-7.0.20.vbox-extpack

echo "At this point you must manually install the OpenVPN host client as root by copying the command listed below"
echo "Rememeber must be root"
echo
echo "bash <(curl -fsS https://as-repository.openvpn.net/as/install.sh)"
