from pysnmp.hlapi import *
import time
from datetime import datetime

# SNMPv3 config
SNMP_USER = 'AdminUser'
AUTH_KEY = 'cisco12345'
PRIV_KEY = 'cisco54321'
TARGET_IP = '192.168.100.1'  # Your SNMP-enabled device IP
INTERFACE_INDEX = 1       # Interface index to monitor 

# OID for ifHCInOctets (64-bit input counter for given interface)
OID_IN = f'1.3.6.1.2.1.31.1.1.1.6.{INTERFACE_INDEX}'

def get_snmp_value(oid):
    response = getCmd(
        SnmpEngine(),
        UsmUserData(SNMP_USER, AUTH_KEY, PRIV_KEY,
                    authProtocol=usmHMACSHAAuthProtocol, #SHA or MD5
                    privProtocol=usmDESPrivProtocol), #DES or AES
        UdpTransportTarget((TARGET_IP, 161), timeout=2, retries=1),
        ContextData(),
        ObjectType(ObjectIdentity(oid))
    )

    # Unpack the response tuple directly (PySNMP 6.x behavior)
    errorIndication, errorStatus, errorIndex, varBinds = response

    if errorIndication:
        print(f"SNMP error: {errorIndication}")
        return None
    elif errorStatus:
        print(f"SNMP error: {errorStatus.prettyPrint()} at index {errorIndex}")
        return None
    else:
        for varBind in varBinds:
            return int(varBind[1])

def main():
    last_value = get_snmp_value(OID_IN)
    if last_value is None:
        print("Initial SNMP request failed. Exiting.")
        return

    last_time = time.time()

    while True:
        time.sleep(5)
        current_value = get_snmp_value(OID_IN)
        current_time = time.time()

        if current_value is not None:
            delta_bits = (current_value - last_value) * 8
            delta_time = current_time - last_time
            bit_rate = delta_bits / delta_time

            timestamp = datetime.now().strftime("%Y-%m-%d %H:%M:%S")
            log_entry = f"{timestamp} - {bit_rate:.2f} bits/sec"
            print(log_entry)

            with open("debit.txt", "a") as f:
                f.write(log_entry + "\n")

            last_value = current_value
            last_time = current_time
        else:
            print("Failed to retrieve SNMP data.")

if __name__ == "__main__":
    main()