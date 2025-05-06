#Traps
sudo systemctl stop snmptrapd
sudo systemctl stop snmptrapd.socket
sudo lsof -i :162

#snmpwalk
sudo systemctl status snmpd
snmpwalk -v2c -c public localhost #public is the community string

