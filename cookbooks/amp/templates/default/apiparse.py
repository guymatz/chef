#!/usr/bin/env python

import sys
import json
from pprint import pprint
import getopt

EXIT_CRITICAL=2
EXIT_WARNING=1
EXIT_OK=0

def usage():
    print ("Usage: %s -i <json-ext-log-> -t <requests|logins> -c <threshold>") % sys.argv[0]
    sys.exit(1)

def CheckRequestRatio(stats, threshold):
    threshold = int(threshold)
    total_reqs = stats['200'] + stats['500']
    if (stats['500'] / total_reqs) * 100 > threshold:
        print "500 Ratio > %i%%" % threshold
        sys.exit(EXIT_CRITICAL)
    else:
        print "500 Ratio < %i%%" % threshold
        sys.exit(EXIT_OK)

def CheckLogins(stats, threshold):
    threshold = int(threshold)
    if stats['LOGIN200'] < threshold:
        print "Fewer than %i logins!" % threshold
        sys.exit(EXIT_CRITICAL)
    else:
        print "Logins OK (%i)" % stats['LOGIN200']
        sys.exit(EXIT_OK)

def main(argv):
    input_file=None
    test=None
    threshold=4
    if len(sys.argv) < 3:
        usage()
    try:
        opts, args = getopt.getopt(argv, "hi:t:c:", ["ifile=", "test=", "threshold="])
    except getopt.GetoptError:
        usage()
    for opt, arg in opts:
        if opt == "-h":
            usage()
        if opt in ("-i", "--ifile"):
            input_file = arg
        if opt in ("-t", "--test"):
            test = arg
        if opt in ("-c", "--threshold"):
            threshold = arg
    if test is None or input_file is None:
        usage()
    test = test.lower()
    if test not in ("requests", "logins"):
        usage()
    if input_file is None:
        input_file = argv[1]
    data = []
    try:
        with open(input_file) as json_data:
            for line in json_data:
                data.append(json.loads(line))
    except IOError:
        print "Cannot read %s" % input_file
    stats = {}
    stats['200'] = data[0]['200']
    stats['500'] = data[0]['500']
    stats['LOGIN200'] = data[0]['api.v1.account.login']['200']
    if test == "requests":
        CheckRequestRatio(stats, threshold)
    elif test == "logins":
        CheckLogins(stats, threshold)

if __name__ == "__main__":
    main(sys.argv[1:])
