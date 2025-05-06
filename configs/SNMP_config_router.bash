#SNMP v2c Configuration
conf t
snmp-server community public RO SNMP_ACL
snmp-server host 192.168.100.10 version 2c public #VM interface address
snmp-server host 192.168.100.10 traps version 2c public udp-port 1162 #I have a problem with the port 162, so I changed it to 1162
snmp-server community public RO 10
access-list 10 permit 192.168.100.10

end 
write memory

#SNMP v3 Configuration
enable
configure terminal
snmp-server view SNMP-RO iso included 
snmp-server group AdminGroup v3 priv read SNMP-RO access SNMP_ACL
snmp-server user AdminUser AdminGroup v3 auth sha cisco12345 priv des56 cisco54321
snmp-server host 192.168.100.10 version 3 priv AdminUser udp-port 1162 #VM interface address
end
write memory

#SNMP Configuration Verification
show snmp user
show snmp group
show snmp community
show snmp #for v2c
show run | include snmp #for v3