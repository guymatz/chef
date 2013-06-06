#!/usr/bin/env python
import requests
from requests.exceptions import *
import sys
import pprint
import json

if len(sys.argv) < 6:
    print "Usage: " + sys.argv[0] + " \"<url>\" <response code> <timeout> \"<key.subkey.subkey.etc>\" \"<value>\""
    sys.exit(1)

url = str(sys.argv[1])
expected_code = int(sys.argv[2])
req_timeout = int(sys.argv[3])
expected_key = str(sys.argv[4])
expected_val = str(sys.argv[5])

EXIT_OK=0
EXIT_WARN=1
EXIT_CRIT=2

def getValue(data, key):
    tree = data
    for subkey in key.split('.'):
        if subkey.isdigit():
            subkey = int(subkey)
        tree = tree[subkey]
    return tree

try:
    req = requests.get(url, timeout=int(req_timeout))
except ConnectionError:
    print "Connection Error: Unable to reach %s" % url
    sys.exit(EXIT_CRIT)
except HTTPError:
    print "Invalid HTTP Response from %s" % url
    sys.exit(EXIT_CRIT)
except:
    print "An unknown error has occured sending request to %s", e % url
    sys.exit(EXIT_CRIT)

if int(req.status_code) != int(expected_code):
    print "The request resulted in HTTP/%s, we expected HTTP/%s" % (req.status_code, expected_code)
    sys.exit(EXIT_CRIT)



j = req.json()
val = getValue(j,expected_key)
if str(val) != str(expected_val):
    print "JSON Response MISS: (%s) %s != %s" % (expected_key, expected_val, val)
    sys.exit(EXIT_CRIT)

print "OK"
sys.exit(EXIT_OK)

