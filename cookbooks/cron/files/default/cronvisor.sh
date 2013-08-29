#!/bin/bash
# ####################################################################
# @FILE cronvisor.sh
# @AUTHOR Gregory Patmore <gregorypatmore@clearchannel.com>
# @DESC Script to aid in reorting results to nagios passive 
# @DEPENDANCIES /usr/bin/nagios_passive.py
# ####################################################################

# tmp files to record output
TMPFOUT=$(mktemp --suffix cronwrap.log);
TMPFERR=$(mktemp --suffix cronwrap.err);
# clean up the tmp files on exit
trap 'rm -rf $TMPFOUT $TMPFERR' SIGINT SIGTERM EXIT;

NAGSPASV_SCRIPT=/usr/bin/nagios_passive.py;
SERVICENAME="GENERIC-SERVICE";

function rpt2Nagios() {};
function showUsage() {};
function logMsg() {};

# detect if we are sourced or main script
if [ "$_" == "$0" ]; then
    # we are the main script


else
    # sourced into another script
    export -f rpt2Nagios;

fi

PATH=$PATH:/bin:/usr/local/bin:/usr/bin:/sbin;
export PATH;
SCRIPT=$(basename $0);


# options string
# -S <servicename> Nagios Passive service name to report to
OPTSTR='S:'







START=$(date +%s)
/bin/bash -c "$3" >$TMPFOUT 2>$TMPFERR
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
NAGSPASV_SCRIPT $CMD_ARGS

# send the actual script output to syslog.
echo "$2 ran in $DURATION seconds (from $START to $END)" | logger -p cron.info -t $2
cat $TMPFILE.out | logger -p cron.info -t $2
cat $TMPFILE.err | logger -p cron.error -t $2

rm $TMPFILE.out
rm $TMPFILE.err

exit $RETVAL
