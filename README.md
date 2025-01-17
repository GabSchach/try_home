docker-compose exec redmine rake redmine:email:receive_imap RAILS_ENV=production \
host=imap.gmail.com \
username=testgabriel44@gmail.com \
password="yfwy ykxq bwcs dtlu" \
port=993 \
ssl=true \
folder=INBOX \
project=support \
tracker=support \
status=new \
priority=normal \
allow_override=all



# Wait a few seconds then check the logs
docker-compose exec redmine tail -f /var/log/redmine/email_fetch.log