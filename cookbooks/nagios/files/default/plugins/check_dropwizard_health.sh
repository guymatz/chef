#!/usr/bin/env bash
# checks the status of a dropwizard app
# Flags for keeping track of options and empty file error condition
hflag=false
pflag=false
zerofile=true

# Timeout value for curl
timeout=45

# Usage output function
usage() { echo "Usage: $0 -h hostname/ip -p port"; exit 2; }

# Error output function that fires when the health status can't be obtained
health_fetch_error() { echo "$1"; exit 2; }

# Option flag handling
while getopts ":h:p:" opt; do
  case "${opt}" in
    h)
      HOST=${OPTARG}
      hflag=true
      ;;
    p)
      PORT=${OPTARG}
      pflag=true
      ;;
    *)
      usage
      ;;
  esac
done 

# Check for mandatory flags
if ! $hflag || ! $pflag ; then
    usage
fi

# Pull the current health status and check for a line that is not OK
rm -f /tmp/healthcheck >/dev/null 2>&1
rm -f /tmp/healthcheck_error >/dev/null 2>&1
curl -m $timeout http://$HOST:$PORT/healthcheck 1> /tmp/healthcheck 2> /tmp/healthcheck_error
if [ $? -ne 0 ]; then
    health_fetch_error "CRITICAL: $(cat /tmp/healthcheck_error)"
fi
if [ ! -e /tmp/healthcheck ]; then
    health_fetch_error "CRITICAL: Could not write to temp file /tmp/healthcheck."
fi

# Read and process the file, fire an error when something is not OK
while read healthfile;do 
    zerofile=false
    echo "$healthfile" | grep -q "OK" >/dev/null 2>&1
    if [ $? -ne 0 ]; then
        echo "$healthfile"
        exit 2
    fi
done < /tmp/healthcheck

# Fire an error if the file was empty
if $zerofile ; then
    health_fetch_error "CRITICAL: Health stats are blank."
fi

# Exit with OK if nothing fired previously
cat /tmp/healthcheck
exit 0
