#!/usr/bin/env python
import sys
import requests
import argparse

# Add parser arguments
parser = argparse.ArgumentParser(description='CLI RabbitMQ Queue Status')
parser.add_argument('--url', help='RabbitMQ HTTP API URL', required=True)
parser.add_argument('--user', help='RabbitMQ auth user', required=True)
parser.add_argument('--password', help='RabbitMQ auth password', required=True)
parser.add_argument('--msgs', help='# of messages to alert on in any queue', required=True)
args = parser.parse_args()

# Grab the connection state json
rabbit_request = requests.get(args.url, auth=(args.user, args.password))
bad_queues = []

# Filter for not running connections
for queue in rabbit_request.json():
    if queue['messages'] > int(args.msgs):
        bad_queues.append(queue)

# Output bad connections if they exist and exit with code 2 (critical)
if len(bad_queues):
    print "CRITICAL: The following queues are backed up!"
    for queue in bad_queues:
        print 'Node: ' + queue['node']
        print 'Queue Name: ' + queue['name']
        print '# of Messages: ' + str(queue['messages'])
        print '-----------------'
    sys.exit(2)
else:
    print "OK: Queues are not backed up."
    sys.exit(0)
