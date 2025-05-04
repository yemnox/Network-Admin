#Create a TAP interface on Ubuntu VM
sudo apt update
sudo apt install -y iproute2 net-tools openvpn
sudo ip tuntap add dev tap1 mode tap
sudo ip link set dev tap1 up
sudo ip addr add 192.168.100.20/24 dev tap1 #IP address of the Interface


#Set up a TAP interface permanently on Ubuntu VM
sudo nano /usr/local/sbin/setup-tap1.sh
    #Paste this code:##################################################
#!/bin/bash
set -e

# Check if tap1 exists; if not, create it
if ! ip link show tap1 &>/dev/null; then
    ip tuntap add dev tap1 mode tap
fi

# Set interface up (safe to rerun)
ip link set dev tap1 up

# Only add IP if it's not already assigned
if ! ip addr show dev tap1 | grep -q "192.168.100.20"; then
    ip addr add 192.168.100.20/24 dev tap1
fi
    #Male it executable##################################################
sudo chmod +x /usr/local/sbin/setup-tap1.sh

#Create a service File
sudo nano /etc/systemd/system/setup-tap0.service
    #Paste this code: 
[Unit]
Description=Setup TAP interface tap0
After=network.target

[Service]
ExecStart=/usr/local/sbin/setup-tap0.sh
Type=oneshot
RemainAfterExit=true

[Install]
WantedBy=multi-user.target


#Enable and Start the Service
sudo systemctl daemon-reexec
sudo systemctl daemon-reload
sudo systemctl enable setup-tap1.service
sudo systemctl start setup-tap1.service

#Check the TAP interface
ip addr show tap1
systemctl status setup-tap1.service