#!/usr/bin/ruby
require 'socket'
require 'timeout'
require 'thor'
require 'net/ping'

class CheckPort < Thor

  # Global
  # TODO: Ensure that this is an argument instead
  @@logstash_port = 50000

desc "evaluate_connection", "Check if the passed as arguments if open"
def evaluate_connection

  # Detect the IPV4 address of self
  node_address = Socket.ip_address_list.detect{|intf| intf.ipv4_private?}
  used_address = node_address.ip_address
  puts "IP Address: " + used_address

  puts "Pinging self on port 50000, UDP"
  ping_action = Net::Ping::UDP.new(used_address, @@logstash_port)
  puts ping_action.ping?
    puts "Available"
	return true
end
  rescue Errno::ECONNREFUSED, Errno::EHOSTUNREACH
    puts "Connection Error"
    return false
end

CheckPort.start(ARGV)
