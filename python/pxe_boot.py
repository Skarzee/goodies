'''
Simple script to set a node based on a config file into PXE mode via the ILO
Created as a workaround for failing IPMI tools, we don't ship HP tools atm

Usage:
    * Create a config.yml and a top section called 'ilo'
    * Define a hostname/ip, username, and password
    * Run it, it will prompt you before doing a restart
'''

import hpilo
import time
import yaml

# Read in configuration file
with open('config.yml', 'rb') as config_file:
    cfg = yaml.load(config_file)

hostname = cfg['ilo']['hostname']
ilo_username = cfg['ilo']['username']
ilo_password = cfg['ilo']['password']

# Create a new connection
ilo = hpilo.Ilo(hostname, ilo_username, ilo_password)


def main():

    # Get current boot method
    boot_method = ilo.get_one_time_boot()
    print ('Current both method is: ' + boot_method.lower())

    if boot_method == 'network':
        print ('\n/!\ Boot method is already defined as "network"')
        return 1
    else:
        print ('\nSetting boot method to network')
        ilo.set_one_time_boot('network')
        time.sleep(1)

        print ('\nQuerying boot method...')
        boot_response = ilo.get_one_time_boot()
        print ('Boot method is set to: ' + boot_response.lower())

        user_response = raw_input('Do you want to reboot? [yY]')
        if user_response in ['y', 'Y']:
            print ('Sending reset request')
            ilo.reset_server()


main()
