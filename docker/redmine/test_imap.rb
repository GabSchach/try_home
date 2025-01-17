require 'net/imap'

def test_imap_connection
  puts "Testing IMAP connection..."
  begin
    imap = Net::IMAP.new('imap.gmail.com', 993, true)
    puts "Connected to IMAP server"
    
    # Try plain login instead of authenticate
    imap.login('testgabriel44@gmail.com', 'yfwy ykxq bwcs dtlu')
    puts "Login successful"
    
    imap.examine('INBOX')
    puts "INBOX accessed successfully"
    
    messages = imap.search(['ALL'])
    puts "Found #{messages.length} messages"
    
    imap.disconnect
    puts "Disconnected successfully"
  rescue => e
    puts "Error: #{e.message}"
    puts e.backtrace
  end
end

test_imap_connection