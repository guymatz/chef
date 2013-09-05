#!/bin/bash
# ####################################################################
# @FILE cronvisor.sh
# @AUTHOR Gregory Patmore <gregorypatmore@clearchannel.com>
# @DESC Script to aid in reorting results to nagios passive 
# @DEPENDANCIES /usr/bin/nagios_passive.py
# @DEPENDANCIES '--' between options and command execution 
# ####################################################################

# cronvisor.sh -S|--service-name <servicename> -- <command> <command_args>

# /usr/lib/nagios/plugins/send_nsca nagios-iad.ihrdev.com  -c /etc/nagios/send_nsca.conf "msg"

declare -r START_TIME=$(date +%s)

# handy handle to the script
declare -r SCRIPT=$(basename $0);
# name of the nagios passive service
declare SVC_NM;
# hostname of the nagios server to report to
declare -r NAG_SVR='nagios-iad.ihrdev.com';
# host name of the server we are running on
declare -r HOST_NAME=$(uname -n);
# token separating arg to this script vs args to underlying script call
declare -r CMD_DELIM='--';
# sentinel to flag when we've hit the end of the script args.
declare -i DELIM_FOUND=0;
# handle to the command we need to run
declare SUB_CMD

# declare -r NAGSPASV_SCRIPT=/usr/bin/nagios_passive.py;
# [[ ! -x $NAGSPASV_SCRIPT ]] \
#     && echo "$SCRIPT: Error $NAGSPASV_SCRIPT permission denied to execute" \
#     && exit 1;

# handle to the nsca config file
declare -r NSCA_CONF=/etc/nagios/send_nsca.conf;
[[ ! -f $NSCA_CONF ]] \
    && echo "${SCRIPT}: ERROR: nsca conf file not found (${NSCA_CONF})" \
    && exit 1;

# handle to the send_nsca executable
declare -r SEND_NSCA_CMD=/usr/lib/nagios/plugins/send_nsca;
[[ ! -x $SEND_NSCA_CMD ]] \
    && echo "${SCRIPT}: ERROR: send_nsca command not found or not executable (${SEND_NSCA_CMD})" \
    && exit 1;

# argument processing 
#loop through each arg until we hit the command delimiter
while [ "$1" != "" ] && [ $DELIM -eq 0 ]; do 
    case $1 in 

        # nagios passive service name to report to
        -S | --service-name )
            shift;
            SVC_NM="${1}";
            shift;
            ;;

        # command delimiter. everything after this is interpreted as an arg to the underlying command
        ${CMD_DELIM} )
            shift;
            DELIM_FOUND=1;
            ;;

        # unknown argument
        * )
            echo "${SCRIPT}: ERROR: unknown argument passed to script (${1})"
            exit 1;
            ;;

    esac
done;

# make sure we have a service name or else bail
[[ -z "${SVC_NM}" ]] \
    && echo "${SCRIPT}: ERROR: No service name passed as argument." \
    && exit 1;

# if we don't have a command to run after argument processing, bail
[[ "${1}" == "" ]] \
    && echo "${SCRIPT}: ERROR: No command to run passed as argument" \
    && exit 1;

# if first arg is not executable, bail
[[ ! -x $1 ]] \
    && echo "${SCRIPT}: ERROR: not able to execute command script (${1})" \
    && exit 1;

PATH=$PATH:/bin:/usr/local/bin:/usr/bin:/sbin;
export PATH;


# tmp files to record output/errput
TMPF_OUT=$(mktemp --suffix cronwrap.log);
TMPF_ERR=$(mktemp --suffix cronwrap.err);

# clean up the tmp files on exit
trap 'rm -rf $TMPFOUT $TMPFERR' SIGINT SIGTERM EXIT;

 >$TMPFOUT 2>$TMPFERR
RETVAL=$?        # one for our exit value
NRETVAL=$RETVAL  # for nagios_passive


if [ $NRETVAL -gt 0 ]; then
    STATUS="An unknown error has occurred (after running for $DURATION seconds)"
    NRETVAL=1
else
    STATUS="OK - $2 ran in $DURATION seconds"
fi

CMD_ARGS=$(echo -e "$HOST\t$SERVICENAME\t$NRETVAL\t$STATUS")
NAGSPASV_SCRIPT $CMD_ARGS


cat $TMPFILE.out | logger -p cron.info -t $2
cat $TMPFILE.err | logger -p cron.error -t $2

rm $TMPFILE.out
rm $TMPFILE.err

exit $RETVAL
