FROM redmine:5.0

# Install required dependencies
RUN apt-get update && apt-get install -y \
    imagemagick \
    libmagickwand-dev \
    libpq-dev \
    build-essential \
    curl \
    cron \
    procps \
    postgresql-client \
    && rm -rf /var/lib/apt/lists/*

# Set up Ruby environment
ENV PATH="/usr/local/bundle/bin:/usr/local/bin:/usr/bin:/bin:${PATH}"
ENV GEM_HOME="/usr/local/bundle"
ENV BUNDLE_APP_CONFIG="/usr/local/bundle"

# Install additional gems for email handling
RUN gem install bundler && \
    gem install mail redmine_crm && \
    gem install rmagick -- --with-opt-lib=/usr/lib

# Create log directory and set permissions
RUN mkdir -p /var/log/redmine && \
    chown -R redmine:redmine /var/log/redmine && \
    chmod 755 /var/log/redmine

# Copy configuration files
COPY database.yml config/
COPY configuration.yml config/
COPY fetch_emails.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/fetch_emails.sh

# Setup cron environment
RUN echo "SHELL=/bin/bash\n\
PATH=/usr/local/bundle/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin\n\
GEM_HOME=/usr/local/bundle\n\
BUNDLE_APP_CONFIG=/usr/local/bundle\n\
RAILS_ENV=production\n\
" > /etc/environment

# Setup cron job
RUN echo "* * * * * root /usr/local/bin/fetch_emails.sh 2>&1" > /etc/cron.d/fetch-emails && \
    chmod 0644 /etc/cron.d/fetch-emails

# Copy and set permissions for entrypoint
COPY docker-entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/docker-entrypoint.sh

ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]