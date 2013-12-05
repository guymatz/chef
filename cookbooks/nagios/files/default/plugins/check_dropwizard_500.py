#!/usr/bin/env python
import sys
import requests
import argparse

# Add parser arguments
parser = argparse.ArgumentParser(description='Dropwizard 5xx Status')
parser.add_argument('--url', help='Dropwizard Metrics URL', required=True)
parser.add_argument('--errno', help='# of 5xx errors to alert on', required=True)
args = parser.parse_args()

# Grab the dropwizard metrics json
dw_request = requests.get(args.url)

# Filter for 5xx errors
dw_errors = int(dw_request.json()['org.eclipse.jetty.servlet.ServletContextHandler']['5xx-responses']['m1'])

# Fire critical if 5xx errors are detected
if dw_errors > int(args.errno):
    print "CRITICAL: There are " + str(dw_errors) + " 5xx errors!"
    sys.exit(2)
else:
    print "OK: 5xx errors are within expectations."
    sys.exit(0)
