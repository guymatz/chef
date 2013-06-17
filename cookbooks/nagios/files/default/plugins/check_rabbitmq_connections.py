#!/usr/bin/env python
import sys
import simplejson as json
import requests
import argparse

# Add parser arguments
parser = argparse.ArgumentParser(description='CLI RabbitMQ Connection Status')
parser.add_argument('--url', help='RabbitMQ HTTP API URL', required=True)
parser.add_argument('--user', help='RabbitMQ auth user', required=True)
parser.add_argument('--password', help='RabbitMQ auth password', required=True)
args = parser.parse_args()

# Grab the connection state json
rabbit_request = requests.get(args.url, auth=(args.user, args.password))
bad_connections = []

# Filter for not running connections
for connection in rabbit_request.json():
    if connection['state'] != 'running':
        bad_connections.append(connection)

# Output bad connections if they exist and exit with code 2 (critical)
if len(bad_connections):
    print "CRITICAL: The following connections are not running!"
    for connection in bad_connections:
        print 'Node: ' + connection['node']
        print 'User: ' + connection['user']
        print 'State: ' + connection['state']
        print 'Last Blocked By: ' + connection['last_blocked_by']
    sys.exit(2)
else:
    print "OK: All connections are running."
    sys.exit(0)
