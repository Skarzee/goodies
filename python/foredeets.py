# Return information for hosts based on hostgroup

import requests
import sys

# Define the foreman instance
FOREMAN = '<FQDN>'  # e.g foreman-01.foobar.com
USERNAME = '<username>'
PASSWORD = '<password>'


def main(hostgroup):

    url = ('https://' + FOREMAN + '/api/v2/hosts?search=hostgroup=' + str(hostgroup) + '&format=json')

    if hostgroup > 0:

        hosts = get_results(url)
        for host in hosts:
            print "ID: %-10d Name: %-30s IP: %-20s OS: %-30s" % (host['id'], host['name'], host['ip'], host['operatingsystem_name'])


def get_json(url):
    ''' get_json: make a get request that returns json '''
    r = requests.get(url, auth=(USERNAME, PASSWORD), verify=False)
    return r.json()


def get_results(url):
    ''' get_results: get json from a url '''

    jsn = get_json(url)
    if jsn.get('error'):
        print('Error: ' + jsn['error']['message'])
    else:
        if jsn.get('results'):
            return jsn['results']
        elif 'results' not in jsn:
            return jsn
        else:
            print "Nothing found"


if __name__ == "__main__":
    main(sys.argv[1])
