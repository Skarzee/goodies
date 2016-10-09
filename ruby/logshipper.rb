# Send a random string to a UDP port to test different inputs.
# This was used to quickly test the shipping of a log stream log to logstash

require 'socket'
require 'securerandom'

# New UDP Socket, and Connection
udp_client=UDPSocket.new
udp_client.connect('10.10.6.81', 50000)
while true
  sleep(2)
  input_generator = SecureRandom.hex()
  input_generator = input_generator.to_s
  #socket.send(payload, 0, UDP_HOST, UDP_PORT)
  udp_client.write(input_generator)
  STDOUT.write(input_generator)
end


