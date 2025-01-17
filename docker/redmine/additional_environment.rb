config.logger = Logger.new(STDOUT)
config.logger.level = Logger::INFO

# Enable IMAP email configuration
config.action_mailer.perform_deliveries = true
config.action_mailer.raise_delivery_errors = true