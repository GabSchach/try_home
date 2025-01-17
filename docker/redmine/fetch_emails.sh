#!/bin/bash

# Set the Ruby environment
export PATH="/usr/local/bin:/usr/bin:/bin:/usr/local/bundle/bin"
export GEM_HOME="/usr/local/bundle"
export BUNDLE_APP_CONFIG="/usr/local/bundle"
export RAILS_ENV=production

# Ensure log directory and file exist
mkdir -p /var/log/redmine
touch /var/log/redmine/email_fetch.log
chown -R redmine:redmine /var/log/redmine

# Change to Redmine directory
cd /usr/src/redmine

# Create log entry with timestamp
echo "[$(date)] Starting email fetch" >> /var/log/redmine/email_fetch.log

# Run the rake task using bundle exec
bundle exec rake redmine:email:receive_imap \
host=imap.gmail.com \
username=testgabriel44@gmail.com \
password="yfwy ykxq bwcs dtlu" \
port=993 \
ssl=true \
folder=INBOX \
project=support \
tracker=Support \
unknown_user=create \
no_permission_check=1 \
allow_override=all 2>&1 >> /var/log/redmine/email_fetch.log

echo "[$(date)] Completed email fetch" >> /var/log/redmine/email_fetch.log