#!/usr/bin/python2.7
import requests
import sys
import argparse
from xml.etree import ElementTree

# Add parser arguments
parser = argparse.ArgumentParser(description='CLI AIS Mount Health Check')
parser.add_argument('--url', help='AIS Stats URL', required=True)
parser.add_argument('--user', help='AIS Monitoring User', required=True)
parser.add_argument('--password', help='AIS Monitoring Password', required=True)
parser.add_argument('--secs', help='Minimum uptime to check for in seconds', required=True)
args = parser.parse_args()

# Try to get the stats page
try:
    ais_stat_request = requests.get(args.url, auth=(args.user, args.password), timeout=2)
except requests.exceptions.Timeout:
    print "Timed out getting {0}.".format(args.url)
    sys.exit(2)
except requests.exceptions.ConnectionError:
    print "There was an error connecting to {0}.".format(args.url)
    sys.exit(2)

# Make sure we got the stats page
if ais_stat_request.status_code != 200:
    print "Got response {0} while trying to access {1}.".format(ais_stat_request.status_code, args.url)
    sys.exit(2)

# Parse the XML
ais_stat_request_tree = ElementTree.fromstring(ais_stat_request.content)
ais_mounts = []

# Go through the mounts and look for any that have been up for less than the desired time
for mount in ais_stat_request_tree.iter('mount'):
    if int(mount[1].text) < int(args.secs):
        ais_mounts.append({ 'mount_name': mount[0].text, 'mount_uptime': int(mount[1].text) })

# Output all the mounts that have been up for less than the desired time
if len(ais_mounts) > 0:
    print "CRITICAL: The following streams have been up for less than {0} seconds:".format(args.secs)
    for bad_mount in ais_mounts:
        print "Mount Name: {0:10}  |  Mount Uptime: {1}".format(bad_mount['mount_name'], bad_mount['mount_uptime'])
    exit(2)

# If you made it this far, all is well!
print "OK: All mounts are up."
exit(0)
