#!/bin/bash

PATH=$PATH:/bin
PATH=$PATH:/usr/local/bin
PATH=$PATH:/usr/bin
PATH=$PATH:/sbin
export PATH

$(/bin/bash -n $0 >> /dev/null 2>&1)
if [ $? -ne 0 ]; then
    $(/bin/bash -n $0)
    echo
    echo "This script has syntax errors, try again!"
    echo
    exit 255
fi

if [ $# -lt 3 ]; then
    echo
    echo "   Usage:"
    echo "   $0 host service \"quoted command\""
    echo
    exit 254
fi


# Which host are we supposed to run on?
BATCH_IP=$(host $1 | awk '/has address/ {print $4}')

# Does that IP even exist?
# Possibly due to network issues, so don't make noise
if [ -z $BATCH_IP ]; then
    # echo "Invalid host to run on -- cannot resolve $1"
    exit 150
fi

# IP exists. Do we have it?
CONCH=$(ip addr show | egrep "${BATCH_IP}" | wc -l)
if [ "$CONCH" -eq 0 ]; then
    # Nope, we don't have it
    exit 0
fi

TMPFILE="/var/tmp/cronwrap.$$"
HOST=$1
SERVICENAME=$2
START=$(date +%s)
/bin/bash -c "$3" >$TMPFILE.out 2>$TMPFILE.err
RETVAL=$?        # one for our exit value
NRETVAL=$RETVAL  # for nagios_passive
END=$(date +%s)
DURATION=$(echo $END - $START | bc)

if [ $NRETVAL -gt 0 ]; then
    STATUS="An unknown error has occurred (after running for $DURATION seconds)"
    NRETVAL=1
else
    STATUS="OK - $2 ran in $DURATION seconds"
fi

CMD_ARGS=$(echo -e "$HOST\t$SERVICENAME\t$NRETVAL\t$STATUS")
/usr/bin/nagios_passive.py $CMD_ARGS

# send the actual script output to syslog.
echo "$2 ran in $DURATION seconds (from $START to $END)" | logger -p cron.info -t $2
cat $TMPFILE.out | logger -p cron.info -t $2
cat $TMPFILE.err | logger -p cron.error -t $2

rm $TMPFILE.out
rm $TMPFILE.err

exit $RETVAL
