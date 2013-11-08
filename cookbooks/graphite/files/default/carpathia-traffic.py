#!/usr/bin/python

from datetime import datetime, timedelta
from pyquery import PyQuery as pq
import re
import socket
import urllib2

URL = 'http://traffic.carpathiahost.com/95.php?customer=&smonth={month}&sday={day}&syear={year}&shour={hour}&smin={min}&emonth={month}&eday={day}&eyear={year}&ehour={hour}&emin={min}'

graphite = socket.create_connection(('graphite.ihrint.com', 2003))

auth_handler = urllib2.HTTPBasicAuthHandler()
auth_handler.add_password(realm='rtg', uri='http://traffic.carpathiahost.com/', user='iheartradio', passwd='VNCh7QjWfT9kX')
opener = urllib2.build_opener(auth_handler)
urllib2.install_opener(opener)

stats = {}
when = datetime.now() - timedelta(minutes=1)
when_stamp = when.strftime('%s')

url = URL.format(**{
	'month': when.month,
	'day': when.day,
	'year': when.year,
	'hour': when.hour,
	'min': when.minute,
})

doc = pq(urllib2.urlopen(url).read())
trs = doc.find('tr')

# filter with :contains doesn't work
for tr in trs.filter(lambda el: pq(this).find('td')):
	tds = pq(tr).find('td')
	name = tds[0].text
	vals = {
		'avg_in': float(tds[1].text),
		'avg_out': float(tds[2].text),
		'max_in': float(tds[1].text),
		'max_out': float(tds[2].text),
		'total_in': float(tds[8].text),
		'total_out': float(tds[9].text),
	}

	curr = stats.get(name, None)
	if curr:
		for k, v in curr.iteritems():
			curr[k] += vals[k]
	else:
		stats[name] = vals

for dev, vs in stats.iteritems():
	dev = re.sub(r'(iheartradio )|(-?,?fw\d)*', '', dev).lower()

	for stat, val in vs.iteritems():
		graphite.send('carpathia.%s.%s %f %s\n' % (dev, stat, val, when_stamp))
