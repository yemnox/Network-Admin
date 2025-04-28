#SNMP client Config
apt-get install snmp snmp-mibs-downloader

#Edit config file
nano /etc/snmp/snmp.conf

#Install telegraf
mkdir /downloads
cd /downloads
wget https://dl.influxdata.com/telegraf/releases/telegraf_1.12.1-1_amd64.deb
dpkg -i telegraf_1.12.1-1_amd64.deb
mkdir /downloads
cd /downloads
wget https://dl.influxdata.com/telegraf/releases/telegraf_1.12.1-1_amd64.deb
dpkg -i telegraf_1.12.1-1_amd64.deb
 
#Edit telegraf config file
nano/etc/telegraf/telegraf.conf

#Check Installation
systemctl enable --now telegraf
systemctl status telegraf