#!/bin/bash

# Monitor cron service
monitor_cron() {
    if ! service cron status > /dev/null; then
        echo "[$(date)] Cron service is down, attempting to restart..."
        service cron start
    fi
}

# Monitor log file
monitor_log() {
    if [ ! -f /var/log/redmine/email_fetch.log ]; then
        echo "[$(date)] Log file missing, creating..."
        touch /var/log/redmine/email_fetch.log
        chown redmine:redmine /var/log/redmine/email_fetch.log
    fi
}

# Main monitoring loop
while true; do
    monitor_cron
    monitor_log
    sleep 30
done