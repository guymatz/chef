#!/usr/bin/python
import socket, os
from time import time, sleep
from pickle import dumps
from xml.etree import ElementTree
from subprocess import Popen, PIPE, STDOUT

VARNISH_FIELDS = 'client_conn,client_req,cache_hit,cache_miss,backend_conn,backend_reuse,backend_toolate,backend_recycle'

CARBON_SERVER = os.getenv('CARBON_HOST')
CARBON_PORT = os.getenv('CARBON_PORT', 2003)

PATH = 'varnish.{0}'.format('.'.join(reversed(socket.gethostname().split('.'))))

def pump_stats():
    p = Popen(['varnishstat', '-x', '-f', VARNISH_FIELDS], stdin=PIPE, stdout=PIPE, stderr=STDOUT, close_fds=True)
    xmlstr = p.stdout.read()

    dom = ElementTree.fromstring(xmlstr)
    now = int(time())

    message = []
    for stat in dom.findall('stat'):
        message.append(
            '{0} {1} {2}'.format(
                '{0}.{1}'.format(PATH, stat.find('name').text),
                stat.find('value').text,
                now
            )
        )

    sock = socket.socket()
    sock.connect((CARBON_SERVER, CARBON_PORT))
    sock.sendall('\n'.join(message))
    sock.close()

if __name__ == '__main__':
    if CARBON_SERVER is None:
        print 'Please set CARBON_HOST equal to the running carbon daemon IP address.'
    else:
        while True:
            try:
                pump_stats()
                sleep(5)
            except KeyboardInterrupt:
                break