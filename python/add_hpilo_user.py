#!/usr/bin/python

# Adds a user through hpilo
# Does it via args
# TODO Add something to check if user exists
# TODO add a way to escape the whole usage of '-' which is used in foreman user

import argparse
import logging
import hpilo

def main():

    logging.basicConfig(level=logging.DEBUG)

    parser = argparse.ArgumentParser(description='Python wrapper for hpilo. Lists out users, adds a new user of your choice.')

    parser.add_argument('-ul', '--username',
        help="Username to add", required = False)

    parser.add_argument('-up', '--password',
        help="Password to add", required = False)

    parser.add_argument('-ilou', '--ilo_username',
        help='HP ILO username', required = True)

    parser.add_argument('-ilop', '--ilo_password',
        help='HP ILO password', required = True)

    parser.add_argument('-ho', '--hostname',
        help='FQDN/IP', required = True)

    args = parser.parse_args()

    # Create a list of parameters
    params = {}
    params['username'] = args.username
    params['password'] = args.password
    params['ilo_username'] = args.ilo_username
    params['ilo_password'] = args.ilo_password
    params['hostname'] = args.hostname

    print params
    hostname = params.get(str('hostname'))
    ilo_username = params.get(str('ilo_username'))
    ilo_password = params.get(str('ilo_password'))
    username = params.get(str('username'))
    password = params.get(str('password'))
    print (hostname, ilo_password, ilo_username, username, password)

    #users = print_users(hostname, ilo_username, ilo_password)

    if username is not None:
        print ('Adding new user ', username)
        add_user(hostname, ilo_username, ilo_password, username, password)

def print_users(hostname, ilo_username, ilo_password):

    print ('Current users: ')
    ilo = hpilo.Ilo(hostname, ilo_username, ilo_password)
    usernames = ilo.get_all_users()
    print(usernames)

def add_user(hostname, ilo_username, ilo_password, username, password):

    ilo = hpilo.Ilo(hostname, ilo_username, ilo_password)

    print('Connected!')
    print username, password

    # add the the user
    ilo.add_user(user_name = username, user_login = username, password = password, admin_priv=True)
    print ('Added ', username)

main()

