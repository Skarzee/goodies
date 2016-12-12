!#/usr/bin/ruby

require 'json'
require 'socket'
require 'time'
require 'date'

while true
  sleep 2
  tcp_client=TCPSocket.new('10.10.1.17',4444)
  time = Time.now.utc.iso8601(3)
  my_hash = {:message => "candyman", :@timestamp => time, :@version => '1'}
  #socket.send(payload, 0, UDP_HOST, UDP_PORT)
  tcp_client.write(my_hash.to_json)
  STDOUT.write(my_hash)
  tcp_client.close
end
