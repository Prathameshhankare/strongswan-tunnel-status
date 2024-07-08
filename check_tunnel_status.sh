#!/bin/bash

# Log file
LOG_FILE="/var/log/ipsec_tunnel.log"

# Check if connection name is provided
if [ -z "$1" ]; then
    echo "Usage: $0 <connection_name>"
    exit 1
fi

# IPsec connection name
CONNECTION_NAME="$1"

# Full path to strongswan command
STRONGSWAN_CMD="/sbin/strongswan"

# Ensure the PATH is set correctly for cron jobs
export PATH="/sbin:/bin:/usr/sbin:/usr/bin"

# IPsec status command
IPSEC_STATUS_CMD="$STRONGSWAN_CMD status"

# IPsec up command
IPSEC_UP_CMD="$STRONGSWAN_CMD up $CONNECTION_NAME"

# Function to log messages
log() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') - $1" >> $LOG_FILE
}

# Check if the IPsec tunnel is established
log "Checking IPsec tunnel status for connection: $CONNECTION_NAME"
TUNNEL_STATUS=$($IPSEC_STATUS_CMD | grep "$CONNECTION_NAME" | grep "ESTABLISHED")

if [ -z "$TUNNEL_STATUS" ]; then
    log "IPsec tunnel for connection: $CONNECTION_NAME is down. Attempting to bring it up."
    $IPSEC_UP_CMD >> $LOG_FILE 2>&1
    if [ $? -eq 0 ]; then
        log "Successfully brought the IPsec tunnel up for connection: $CONNECTION_NAME."
    else
        log "Failed to bring the IPsec tunnel up for connection: $CONNECTION_NAME."
    fi
else
    log "IPsec tunnel for connection: $CONNECTION_NAME is already established."
fi
