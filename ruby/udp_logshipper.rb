#!/usr/bin/ruby 
# Send a random string to a UDP port to access the affectiveness of the IMUDP Rsyslog Module.
require 'socket'
require 'securerandom'
 
# New UDP Socket, and Connection
# TODO: Specify Client and port with credentials
udp_client=UDPSocket.new
udp_client.connect('10.10.6.81', 50000)
while true
  sleep(2)
  generatedInput = SecureRandom.hex.to_s
  udp_client.write(generatedInput)
  STDOUT.write(input_generator)
end
