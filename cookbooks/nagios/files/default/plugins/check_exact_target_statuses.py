#!/usr/bin/env python
import re
import sys


log = open('/data/log/responsys-consumer/consumer.log', 'r')
pos = open('/tmp/pos.dat','r')
log_len = 0
line_count_of_truncated_file = 0
STATUS_matches = 0
STATUS_OK_matches = 0

for line in (log):
 log_len += 1

#print log_len
pos_len = int(pos.readline())

pos.close()

if (log_len < pos_len):
 print "Truncating positional data"
 pos = open('/tmp/pos.dat','w')
 pos.write(str(0))
 pos_len = 0
 sys.exit(0)

log.seek(int(pos_len))

curr_log_pos = log.tell()

#print curr_log_pos

while (curr_log_pos < log_len):
 this_line = log.readline()
 curr_log_pos += 1
 if (re.search('Status::', this_line)):
  STATUS_matches += 1
  if (re.search('Status::OK', this_line)):
   STATUS_OK_matches += 1

print STATUS_matches
print STATUS_OK_matches

if ((((STATUS_matches - STATUS_OK_matches) / STATUS_matches) * 100) > 5):
 print "Too many bad Statuses!"
 pos = open('/tmp/pos.dat','w')
 pos.write(str(log_len))
 sys.exit(2)

if (STATUS_OK_matches < 1):
 print "No Status::OK strings!"
 pos = open('/tmp/pos.dat','w')
 pos.write(str(log_len))
 sys.exit(2)

print "OK"
pos = open('/tmp/pos.dat','w')
pos.write(str(log_len))
sys.exit(0)
