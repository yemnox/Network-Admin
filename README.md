# Network-Admin

A collection of network administration scripts and configurations focused on **SNMP (Simple Network Management Protocol)** monitoring, data collection, and real-time visualization.

---

## 📁 Repository Structure

```
Network-Admin/
├── configs/
│   └── SNMP_config_router.bash       # Cisco router SNMP v2c & v3 configuration commands
├── SNMP_Data_Rate_Plot/
│   └── v3/
│       ├── snmp_debit.py             # SNMPv3 data rate collector (polls interface counters)
│       ├── snmp_plot.py              # Real-time bit rate plotter using matplotlib
│       └── debit.txt                 # Output log file for collected bit rate data
└── Tests/
    └── SNMP.bash                     # SNMP service test & verification commands
```

---

## 📦 Modules

### `configs/SNMP_config_router.bash`
Cisco IOS configuration commands for enabling SNMP on a router:
- **SNMPv2c**: Sets up a read-only community string with ACL-based access control and configures trap destinations.
- **SNMPv3**: Creates a secure SNMP view, group (`AdminGroup`), and user (`AdminUser`) with SHA authentication and DES56 privacy encryption.
- **Verification**: Commands to verify the SNMP configuration (`show snmp user`, `show snmp group`, etc.).

> ⚠️ **Note**: The trap port is set to `1162` instead of the standard `162` to work around a port binding issue on the host.

---

### `SNMP_Data_Rate_Plot/v3/`

#### `snmp_debit.py` — SNMPv3 Data Rate Collector
Polls a network device every 5 seconds via **SNMPv3** to measure the incoming bit rate on a specified interface.

- Uses the `pysnmp` library (v6.x API)
- Monitors the `ifHCInOctets` OID (`1.3.6.1.2.1.31.1.1.1.6.<interface_index>`) — a 64-bit input octet counter
- Calculates the bit rate (bits/sec) between consecutive polls
- Logs timestamped results to `debit.txt`

**Configuration (edit at the top of the file):**
| Variable | Description | Default |
|---|---|---|
| `SNMP_USER` | SNMPv3 username | `AdminUser` |
| `AUTH_KEY` | Authentication password (SHA) | `cisco12345` |
| `PRIV_KEY` | Privacy/encryption password (DES) | `cisco54321` |
| `TARGET_IP` | IP address of the SNMP-enabled device | `192.168.100.1` |
| `INTERFACE_INDEX` | Interface index to monitor | `1` |

**Run:**
```bash
python snmp_debit.py
```

---

#### `snmp_plot.py` — Real-time Network Traffic Plotter
Reads `debit.txt` and plots the bit rate data as a live-updating graph using **matplotlib**.

- Updates the graph every 1 second
- X-axis: Sample index (time)
- Y-axis: Bit rate (bits/sec)
- Uses the `TKAgg` backend for display

**Run (alongside `snmp_debit.py`):**
```bash
python snmp_plot.py
```

---

### `Tests/SNMP.bash`
Shell commands for testing and verifying SNMP services on a Linux host:

- Start/stop the `snmptrapd` service and socket
- Check for processes listening on port 162
- Verify the `snmpd` daemon status
- Run a basic `snmpwalk` against localhost using the `public` community string

---

## 🚀 Getting Started

### Prerequisites
- Python 3.x
- [`pysnmp`](https://pypi.org/project/pysnmp/) library
- [`matplotlib`](https://pypi.org/project/matplotlib/) library
- A Cisco (or compatible) router/switch configured with SNMP

### Installation

```bash
pip install pysnmp matplotlib
```

### Usage

1. **Configure your router** using the commands in `configs/SNMP_config_router.bash`.
2. **Start the data collector** to begin polling SNMP data:
   ```bash
   cd SNMP_Data_Rate_Plot/v3
   python snmp_debit.py
   ```
3. **In a separate terminal, start the plotter** to visualize the data in real time:
   ```bash
   cd SNMP_Data_Rate_Plot/v3
   python snmp_plot.py
   ```

---

## 🛠️ Technologies Used

- **Python** — Data collection and visualization scripts
- **Shell / Bash** — Router configuration and service testing
- **SNMP (v2c & v3)** — Network monitoring protocol
- **pysnmp** — Python SNMP library
- **matplotlib** — Real-time data plotting
- **Cisco IOS** — Router/switch configuration

---

## 📝 Notes

- The default configuration targets a device at `192.168.100.1` with interface index `1`. Update these values in `snmp_debit.py` to match your environment.
- SNMPv3 credentials in this repository are for **lab/demo purposes only**. Always use strong, unique credentials in production.
- `debit.txt` is used as an intermediate data file between the collector and the plotter. Ensure both scripts are run from the same directory.
