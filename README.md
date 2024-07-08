# strongswan-tunnel-status
A bash script to verify if the strongSwan IPsec tunnel is established. If not, the script should bring it up and log detailed information.

# IPsec Tunnel Status Check Script

## Overview

This script (`check_tunnel_status.sh`) is designed to monitor the status of an IPSec tunnel using strongSwan. It ensures that the tunnel remains established, and if it detects that the tunnel is down, it attempts to bring it back up automatically.

## Features

- **Monitoring:** Checks the status of the IPSec tunnel.
- **Automatic Reconnection:** If the tunnel is not established, the script attempts to re-establish it.
- **Logging:** Detailed logging of actions and results to a specified log file.
- **Cron Job Integration:** Configurable to run as a cron job every 10 minutes.

## Usage

1. **Installation:**
   - Place `check_tunnel_status.sh` in a suitable directory (e.g., `/usr/local/sbin/`).
   - Ensure the script has executable permissions (`chmod +x check_tunnel_status.sh`).

2. **Configuration:**
   - Modify the script to specify your IPSec connection name (`CONNECTION_NAME`) and log file path (`LOG_FILE`).

3. **Cron Job Setup:**
   - Add a cron job entry to run the script periodically:
     ```
     */10 * * * * root /usr/local/sbin/check_tunnel_status.sh your_connection_name
     ```
     Replace `your_connection_name` with your actual IPSec connection name.

4. **Logging:**
   - Check the specified log file (default: `/var/log/ipsec_tunnel.log`) for script execution logs.

## Example

Suppose your IPSec connection name is `tunnel1`:
```bash
*/10 * * * * root /usr/local/sbin/check_tunnel_status.sh tunnel1
