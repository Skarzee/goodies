#!/usr/bin/ruby

#require 'os'
#require 'sys'
#require 'requests'
require 'json'
require 'net/http'
require 'yaml'

# External Gems
require 'thor'
require 'aws-sdk'
require 'pp'
require 'net/ping'

metadata_endpoint = 'http://169.254.169.254/latest/meta-data/'

# Define profile name

# Make a new connection
# Aws::EC2::Client.new(credentials: @credentials)

class ActivityShift < Thor


  @@profileName = ''
  @@instanceList = []
  #regionName = "eu-central-1"


  desc "pullTags", "Pull out AWS information relating to tag"
	def pullTags
      @credentials = Aws::SharedCredentials.new(profile_name: @profileName)
	  Aws::EC2::Client.new(credentials: @credentials)

	  puts @credentials.inspect
      ec2 = Aws::EC2::Resource.new(region: 'eu-central-1')

	# Set filter for all relevant instances
  filteredInstances = [
      { name: 'tag:aws_cluster', values: ['csgo-poc'] },
  ]

  # Store and interate through the filtered instances
  instanceQuery = ec2.instances(filters: filteredInstances)
		instanceQuery.each do |i|
		  puts "\n"
			puts "ID:    #{i.id}"
			puts "State: #{i.state.name}"
		  instanceAddresses = (i.public_ip_address)
			puts "Public IP: #{i.public_ip_address}"
			@@instanceList.push(instanceAddresses)
		end

  # Interate over the machine list, and for each node send UDP ping
  while true
	@@instanceList.each do |i|
			puts @@instanceList.pretty_inspect
			puts ("UDP ping on node: " + i)
			pingTCP = Net::Ping::UDP.new(i, 50000)
			if pingTCP.ping?
			  pingMs = ( icmp.duration * 1000 )
			  reachable? true
			  puts pingMs
			end
		end
	end
	end


  desc "monitor", "Monitor cluster (ICMP)"
  def monitor
		pullTags.new
	  # Monitor health of Cluster
		puts @@instanceList
    @@instanceList.each do |i|
	    tcpPing = Net::Ping::TCP.new(i)
	    puts tcpPing
	  end
  end

  desc "reassign", "Reassign an IP of instance"
  def reassign
    # Ensure that the credentials are set
	if
	  Aws.credentials.set = false
	  puts('You must set your credentials')
	end
  end

	desc "getInstanceId", "Get instance IDs"
	def getInstanceId
  	# Get Instance ID by querying local API Gateway
  	instance_id = Net::HTTP.get(URI::parse( metadata_base_ip+'instance-id') )
  	puts instance_id
	end

	def ec2_connect
  	ec2_connection = AWS::EC2.new()
	end

#	def main(elastic_ip, instance_id)
#    payload = {'type': 'assign', 'instance_id': instance_id}
#    headers = {'Authorization': 'Bearer {0}'.format(os.environ['secret_key']),
#               'Content-type': 'application/json'}
#    url = api_base + "/floating_ips/{0}/actions".format(floating_ip)
#    r = requests.post(url, headers=headers,  data=json.dumps(payload))

  #  resp = r.json()
  #  if 'message' in resp
  #      print('{0}: {1}'.format(resp['id'], resp['message']))
  #      sys.exit(1)
  #  else
  #      print('Moving IP address: {0}'.format(resp['action']['status']))
  #  end
  #	end
end

# Start the Class using Thor
ActivityShift.start(ARGV)

