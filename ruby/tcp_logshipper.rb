#!/usr/local/bin/ruby -w

# Send a random string to a UDP port to test different inputs.
# This was used to quickly test the shipping of a log stream log to logstash

require 'socket'
require 'securerandom'

# New TCP Socket, and Connection
tcp=TCPSocket.new
tcp.open('10.10.6.51', 9000)
while true
  sleep(2)
  input_generator = SecureRandom.hex()
  input_generator = input_generator.to_s
  #socket.send(payload, 0, UDP_HOST, UDP_PORT)
  udp_client.write(input_generator)
  STDOUT.write(input_generator)
end


