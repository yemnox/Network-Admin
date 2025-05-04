#Install InfluxDB
sudo su
mkdir /downloads
cd /downloads
wget https://dl.influxdata.com/influxdb/releases/influxdb_1.7.8_amd64.deb
dpkg -i influxdb_1.7.8_amd64.deb
mkdir /downloads
cd /downloads
wget https://dl.influxdata.com/influxdb/releases/influxdb_1.7.8_amd64.deb
dpkg -i influxdb_1.7.8_amd64.deb

#Activate InfluxDB
systemctl enable --now influxdb
systemctl status influxdb

#Connect to InfluxDB
influx 
exit