# Find password and store in a readable file

echo | tee -a openvpn-cred
echo "Location of admin web portal:" | tee -a ~/openvpn-cred
sudo cat /usr/local/openvpn_as/init.log | grep "Admin  UI:" | tee -a ~/openvpn-cred
echo | tee -a ~/openvpn-cred
echo "Location of client web portal:" | tee -a ~/openvpn-cred
sudo cat /usr/local/openvpn_as/init.log | grep "Client UI:" | tee -a ~/openvpn-cred
echo | tee -a ~/openvpn-cred
echo "Username and password to acces admin web portal" | tee -a ~/openvpn-cred
sudo cat /usr/local/openvpn_as/init.log | grep "password" | tee -a ~/openvpn-cred

# Open ports through the firewall

sudo firewall-cmd --permanent --add-port=443/tcp
sudo firewall-cmd --permanent --add-port=943/tcp
sudo firewall-cmd --permanent --add-port=6262/tcp
sudo firewall-cmd --permanent --add-port=2222/tcp
sudo firewall-cmd --permanent --add-port=1164/udp

# Add user to the vboxusers group to allow USB forwarding

sudo usermod -a -G vboxusers, libvirt nwadmin

# Create VM for Windows 10 Install to host Micromine License Server

# VBoxManage createvm --name "MMServer" --ostype Windows10_64 --register
# VBoxManage dhcpserver add --network=vboxnet0 --server-ip=192.168.56.1 --netmask=255.255.255.0 --lower-ip=192.168.56.3 --upper-ip=192.168.56.254 --enable
# VBoxManage modifyvm "MMServer" --memory=8192 --cpus=2 --nic1=nat --nic-type1=virtio --cable-connected1=on --nic2=hostonly --nic-type2=virtio --nat-pf1=Micromine,tcp,,6262,,6200 --nat-pf1=SSH,tcp,,2222,,22 --clipboard-mode=bidirectional --drag-and-drop=bidirectional --usb-ehci=on --usb-ohci=on --usb-xhci=on --vram=128 --accelerate-3d=on --graphicscontroller=vboxsvga --intnet2=vboxnet0

clear 
echo "At this time insert the USB and transfer the 'license' folder from the USB to the folder /home/nwadmin/Desktop"

while [[ "$PROMPT" != "y" ]]
do
  read -s -p "Enter y to continue: " PROMPT 
done

okular /home/nwadmin/Desktop/license/README.pdf
