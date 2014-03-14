#!/usr/bin/env bash
# checks the status of a dropwizard app
# Flags for keeping track of options and empty file error condition
hflag=false
bflag=false
zerofile=true

# Timeout value for curl
timeout=45

# Usage output function
usage() { echo "Usage: $0 -h hostname/ip -b bucket"; exit 2; }

# Error output function that fires when the health status can't be obtained
health_fetch_error() { echo "$1"; exit 2; }

# Option flag handling
while getopts ":h:b:" opt; do
  case "${opt}" in
    h)
      HOST=${OPTARG}
      hflag=true
      ;;
    b)
      BUCKET=${OPTARG}
      bflag=true
      ;;
    *)
      usage
      ;;
  esac
done 

# Check for mandatory flags
if ! $hflag || ! $bflag ; then
    usage
fi

rm -f /tmp/healthcheck >/dev/null 2>&1
rm -f /tmp/healthcheck_error >/dev/null 2>&1
rm -f /tmp/s3_error >/dev/null 2>&1
rm -f /tmp/testfile >/dev/null 2>&1

# Test an upload to Riak-CS
echo 'hello world' > /tmp/testfile
s3cmd -P put /tmp/testfile s3://$BUCKET 1> /dev/null 2> /tmp/s3_error
if [ $? -ne 0 ]; then
    health_fetch_error "CRITICAL: $(cat /tmp/s3_error)"
fi

# Test object retrieval from Riak-CS
curl -m $timeout http://$BUCKET.$HOST/testfile 1> /tmp/healthcheck 2> /tmp/healthcheck_error
if [ $? -ne 0 ]; then
    health_fetch_error "CRITICAL: $(cat /tmp/healthcheck_error)"
fi
if [ ! -e /tmp/healthcheck ]; then
    health_fetch_error "CRITICAL: Could not write to temp file /tmp/healthcheck."
fi
# Read and process the file, fire an error when something is not OK
while read healthfile;do 
    zerofile=false
    echo "$healthfile" | grep -q "hello world" >/dev/null 2>&1
    if [ $? -ne 0 ]; then
        echo "$healthfile"
        exit 2
    fi
done < /tmp/healthcheck

# Fire an error if the file was empty
if $zerofile ; then
    health_fetch_error "CRITICAL: Could not retrieve object text."
fi

# Exit with OK if nothing fired previously
echo "OK: Object file read successfully."
exit 0
