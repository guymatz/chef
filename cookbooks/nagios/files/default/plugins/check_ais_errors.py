#!/usr/bin/python2.7
import requests
import sys
import argparse
from xml.etree import ElementTree

# Add parser arguments
parser = argparse.ArgumentParser(description='CLI AIS Error Percentage')
parser.add_argument('--url', help='AIS Stats URL', required=True)
parser.add_argument('--user', help='AIS Monitoring User', required=True)
parser.add_argument('--password', help='AIS Monitoring Password', required=True)
parser.add_argument('--percentage', help='Maximum error percentage allowed', required=True)
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

# Grab responses
req_200 = 0.0
req_400 = 0.0
req_500 = 0.0
for child in ais_stat_request_tree.findall(".//response"):
    if child.attrib['code'] == '2xx':
        req_200 = float(child.text)
    if child.attrib['code'] == '4xx':
        req_400 = float(child.text)
    if child.attrib['code'] == '5xx':
        req_500 = float(child.text)

# Check for 200s
if int(req_200) == 0:
    print "CRITICAL: There are no 200 responses!"
    sys.exit(2)

error_percentage = (req_400 + req_500) / req_200

# Fire critical if error rate is above the maximum desired
if error_percentage > float(args.percentage):
    print "CRITICAL: The error rate is {0:.2f}%.".format(error_percentage)
    sys.exit(2)


# If you made it this far, all is well!
print "OK: Error percentage at {0:.2f}%.".format(error_percentage)
exit(0)
