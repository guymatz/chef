#!/bin/env python

import mechanize
import sys
import base64
import json

target_hostname=sys.argv[1]

username = "thumbplay"
password = "clearchannel"
target_page= "http://" + target_hostname + ":15672/api/nodes"

#print target_page

browser = mechanize.Browser()
browser.addheaders.append(('Authorization', 'Basic %s' % base64.encodestring('%s:%s' % (username, password))))
rest_response=browser.open(target_page)

objects=json.loads(rest_response.read())

for o in objects:
 for key in o.keys():
  if key == 'mem_used':
   memused = o[key]
  if key == 'mem_limit':
   memlimit = o[key]

memutilization=((float(memused) / float(memlimit)) * 100)

if memutilization >= 70.0:
 print "Memory utilization at %70!"
 sys.exit(2)
if memutilization >= 65.0:
 print "Memory utilization at %65!"
 sys.exit(1)
else:
 print "OK"
 sys.exit(0)

#if memlimit



