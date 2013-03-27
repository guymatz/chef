#!/bin/env python

import mechanize
import sys
import base64
import json

target_hostname=sys.argv[1]

username = "thumbplay"
password = "clearchannel"
target_page= "http://" + target_hostname + ":55672/api/nodes"

browser = mechanize.Browser()
browser.addheaders.append(('Authorization', 'Basic %s' % base64.encodestring('%s:%s' % (username, password))))
rest_response=browser.open(target_page)

objects=json.loads(rest_response.read())

for o in objects:
 for key in o.keys():
  if key == 'mem_used':
   memused = o[key]

if memused >= 1200000000:
  print "Rabbit is now using equal to or more than 1.2Gb of memory."
  sys.exit(2)
else:
 print "OK"
 sys.exit(0)
