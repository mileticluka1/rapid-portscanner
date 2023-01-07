require 'optparse'
require 'socket'

# Parse command-line arguments
options = {}
OptionParser.new do |opts|
  opts.banner = "Usage: port_scanner.rb [options]"
  opts.on("-h", "--host HOST", "Target host") do |host|
    options[:host] = host
  end
  opts.on("-p", "--ports PORTS", "Comma-separated list of ports to scan (e.g. 1-100,200,300)") do |ports|
    options[:ports] = ports
  end
  opts.on("-m", "--message MESSAGE", "Message to send to each port (default: 'HELLO')") do |message|
    options[:message] = message
  end
end.parse!

# Validate command-line arguments
if options[:host].nil? || options[:ports].nil?
  puts "Error: host and port range are required arguments"
  exit
end

# Parse the port range
ports = []
options[:ports].split(',').each do |range|
  if range.include?('-')
    start, stop = range.split('-')
    (start.to_i..stop.to_i).each do |port|
      ports << port
    end
  else
    ports << range.to_i
  end
end

# Set the message to send to each port (default: 'HELLO')
message = options[:message] || 'HELLO'

# Iterate through the port range
ports.each do |port|
  begin
    # Create a socket and attempt to connect to the target host on the current port
    s = TCPSocket.new(options[:host], port)
    # Send the message and read the response
    s.puts(message)
    response = s.gets
    puts "Port #{port}: #{response}"
    s.close
  rescue Errno::ECONNREFUSED, Errno::EHOSTUNREACH
    # If the connection is refused or the host is unreachable, the port is closed
    puts "Port #{port}: Connection refused"
  end
end
