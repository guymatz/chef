#!/usr/bin/env python
import sys
import requests
import argparse

# Add parser arguments
parser = argparse.ArgumentParser(description='Subscription Service Updater')
parser.add_argument('--url', help='Subscription Service POST URL', required=True)
args = parser.parse_args()

# Initiate the subscription update
sub_post = requests.post(args.url, timeout=300)

# Grab the error code and error description if there is one
try:
    sub_error = int(sub_post.json()['errorCode'])
    sub_error_desc = sub_post.json()['errorDescription']
except KeyError:
    sub_error = 0
    sub_updated = sub_post.json()['numUpdated']

# Fire critical if errorCode != 0
if sub_error != 0:
    print "CRITICAL: The subscription update failed with error code " + str(sub_error) + " and description " + sub_error_desc + "."
    sys.exit(2)
else:
    print "OK: " + str(sub_updated) + " subscriptions updated successfully."
    sys.exit(0)
