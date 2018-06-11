#!/usr/local/bin/ruby

require 'json'
require 'socket'
require 'date'
require 'securerandom'

# TODO: This loop kinda sucks, it could do with presvering the TCP connection and sending a fresh stream.
# Specify things via arguments
while true
  sleep 2
  tcp_client=TCPSocket.new('10.10.6.81',7777)
  generatedInput = SecureRandom.hex.to_s
  #my_hash = {:message => "candyman", :@timestamp => time, :@version => '1'}
  #socket.send(payload, 0, UDP_HOST, UDP_PORT)
  tcp_client.write(generatedInput.to_json)
  STDOUT.write(generatedInput.to_json)
  tcp_client.close
end
