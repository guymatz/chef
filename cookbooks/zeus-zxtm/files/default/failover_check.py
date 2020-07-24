#!/usr/bin/python -W ignore::DeprecationWarning

from sets import Set
from netifaces import interfaces, ifaddresses, AF_INET
import socket
import re
import os

hostname=socket.gethostname()
ips_on_this_box=[]
vips_file='/root/scripts/vips'

if re.match(hostname, 'iad-lb101.ihr'):
 other_hostname = 'iad-lb102.ihr'
else:
 other_hostname = 'iad-lb101.ihr'

with open(vips_file) as vips_fh:
 ips_arr=vips_fh.readlines()
ips_arr = map(lambda s: s.strip(), ips_arr)

for ifaceName in ['bond1.150', 'bond0.200']:
 addresses = [i['addr'] for i in ifaddresses(ifaceName).setdefault(AF_INET, [{'addr':'No IP addr'}] )]
 for address in addresses:
  try:
   address_current_main_fh=open('/tmp/current_main_%s' % address, 'r')
   address_current_main_w_newline=address_current_main_fh.readline()
   address_current_main = address_current_main_w_newline.rstrip()
   match = re.match(address_current_main, hostname)
   if match is None:
    #/usr/sbin/arping -I bond1.150 -c1 -U $ip
    os.system('/usr/sbin/arping -I %s -c1 -U %s' % (ifaceName,address))
    address_current_main_fh=open('/tmp/current_main_%s' % address, 'w')
    address_current_main_fh.write('%s' % hostname)
  except:
   address_current_main_fh=open('/tmp/current_main_%s' % address, 'w')
   address_current_main_fh.write('%s' % hostname)
  ips_on_this_box.append(address)

ips_on_other_host=set(ips_arr) - set(ips_on_this_box)

#print set(ips_arr)
#print set(ips_on_this_box)
#print set(ips_on_other_host)

for ip in ips_on_other_host:
 address_current_main_fh=open('/tmp/current_main_%s' % ip, 'w')
 address_current_main_fh.write('%s' % other_hostname)
