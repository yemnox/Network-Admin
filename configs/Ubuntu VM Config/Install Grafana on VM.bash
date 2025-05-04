apt-get update
apt-get install mysql-server
mysql -u root
CREATE DATABASE grafana CHARACTER SET UTF8 COLLATE UTF8_BIN;
CREATE USER 'grafana'@'%' IDENTIFIED BY 'kamisama123';
GRANT ALL PRIVILEGES ON grafana.* TO 'grafana'@'%';
quit;


#Configure Grafana APT repository
mkdir /downloads/grafana -p
cd /downloads/grafana
wget https://packages.grafana.com/gpg.key
apt-key add gpg.key
add-apt-repository 'deb [arch=amd64,i386] https://packages.grafana.com/oss/deb
stable main'
apt-get update
mkdir /downloads/grafana -p
cd /downloads/grafana
wget https://packages.grafana.com/gpg.key
apt-key add gpg.key
add-apt-repository 'deb [arch=amd64,i386] https://packages.grafana.com/oss/deb
stable main'
apt-get update

#install Grafana
apt-get install grafana

#Edit config file
nano /etc/grafana/grafana.ini

[database]
type = mysql
host = 127.0.0.1:3306
name = grafana
user = grafana
password = kamisama123
[session]
provider = mysql
provider_config = `grafana:kamisama123@tcp(127.0.0.1:3306)/grafana`

service grafana-server start
systemctl enable --now grafana-server
systemctl status grafana-server

#Copy this url in the browser
http://localhost:3000