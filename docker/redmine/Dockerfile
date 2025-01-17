FROM redmine:5.0

# Install required dependencies
RUN apt-get update && apt-get install -y \
    imagemagick \
    libmagickwand-dev \
    libpq-dev \
    build-essential \
    curl \
    && rm -rf /var/lib/apt/lists/*

# Install additional gems for email handling
RUN gem install mail redmine_crm && \
    gem install rmagick -- --with-opt-lib=/usr/lib

# Copy configuration files
COPY configuration.yml config/
COPY test_imap.rb /usr/src/redmine/
RUN chmod +x /usr/src/redmine/test_imap.rb