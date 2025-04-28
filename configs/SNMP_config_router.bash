#SNMP v2c Configuration
conf t
snmp-server community public RO
snmp-server host 192.168.100.10 version 2c public //VM interface address
snmp-server community public RO 10
access-list 10 permit 192.168.100.10
end 
write memory

#SNMP v3 Configuration
enable
configure terminal
snmp-server group AdminGroup v3 priv
snmp-server user AdminUser AdminGroup v3 auth sha cisco12345 priv des56 cisco54321
snmp-server host 192.168.100.10 version 3 priv AdminUser //VM interface address
end
write memory