#!/bin/bash
set -e

# Create log directory and set permissions
mkdir -p /var/log/redmine
chown -R redmine:redmine /var/log/redmine
chmod 755 /var/log/redmine

# Wait for PostgreSQL
until PGPASSWORD=$REDMINE_DB_PASSWORD psql -h postgres -U $REDMINE_DB_USERNAME -d $REDMINE_DB_DATABASE -c '\q'; do
  echo "Postgres is unavailable - sleeping"
  sleep 1
done

echo "Postgres is up - executing migrations"

# Initialize database
bundle exec rake db:migrate RAILS_ENV=production
bundle exec rake redmine:plugins:migrate RAILS_ENV=production
bundle exec rake redmine:load_default_data RAILS_ENV=production REDMINE_LANG=en

# Start cron service
service cron start

# Check if cron is running
if service cron status >/dev/null; then
    echo "Cron service started successfully"
else
    echo "Failed to start cron service"
    exit 1
fi

# Initialize log file
touch /var/log/redmine/email_fetch.log
chown redmine:redmine /var/log/redmine/email_fetch.log

# Start Rails server
exec rails server -b 0.0.0.0