#SNMP client Config
apt-get install snmp snmp-mibs-downloader

#Edit config file
nano /etc/snmp/snmp.conf

#Install telegraf
sudo su
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

#Edit Config file
sudo nano /etc/telegraf/telegraf.conf

#Create SNMP config file
sudo nano /etc/telegraf/telegraf.d/monitor-linux-snmp.conf
    #Paste this code:
[[inputs.snmp]]
  agents = [ "127.0.0.1:161" ] # IP:Port of the SNMP agent
  version = 2
  community = "public"         # Replace with your SNMP community name
  name = "snmp"

  [[inputs.snmp.field]]
    name = "hostname"
    oid = "RFC1213-MIB::sysName.0"
    is_tag = true

  [[inputs.snmp.table]]
    name = "snmp"
    inherit_tags = [ "hostname" ]
    oid = "IF-MIB::ifXTable"

    [[inputs.snmp.table.field]]
      name = "ifName"
      oid = "IF-MIB::ifName"
      is_tag = true


#restart telegraf
sudo systemctl restart telegraf
#test telegraf config
sudo telegraf -config /etc/telegraf/telegraf.d/monitor-linux-snmp.conf --test