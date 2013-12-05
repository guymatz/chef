#!/usr/bin/env bash
# checks the status of a dropwizard app
hflag=false
pflag=false
zerofile=true
usage() { echo "Usage: $0 -h hostname/ip -p port" 1>&2; exit 2; }
health_fetch_error() { echo "CRITICAL: Could not get health status." 1>&2; exit 2; }
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
if ! $hflag ] || ! $pflag ; then
    usage
fi

# Pull the current health status and check for a line that is not OK
rm -f /tmp/healthcheck >/dev/null 2>&1
curl -s http://$HOST:$PORT/healthcheck > /tmp/healthcheck
if [ ! -e /tmp/healthcheck ]; then
    health_fetch_error
fi
while read healthfile;do 
    zerofile=false
    echo "$healthfile" | grep -q "OK" >/dev/null 2>&1
    if [ $? -ne 0 ]; then
        echo "CRITICAL: $healthfile"
        exit 2
    fi
done < /tmp/healthcheck
if $zerofile ; then
    health_fetch_error
fi
echo "OK: Application health checks are fine."
exit 0
