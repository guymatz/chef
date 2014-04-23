#!/bin/bash
# ####################################################################
# @FILE nsca_relay.sh
# @AUTHOR Gregory Patmore <gregorypatmore@clearchannel.com>
# @DESC Script to aid in reorting results to nagios passive 
# @DEPENDANCY /etc/nagios/send_nsca.conf
# @DEPENDANCY /usr/lib/nagios/plugins/send_nsca
# @DEPENDANCY '--' between options and command execution 
# ####################################################################

# cronvisor.sh -S|--service-name <servicename> -- <command> <command_args>

declare -r START_TIME=$(date +%s);
# handy handle to the script
declare -r SCRIPT=$(basename $0);
# name of the nagios passive service
declare SVC_NM;
# hostname of the nagios server to report to
declare -r NAG_SVR='nagios-iad.ihrdev.com';
# host name of the server we are running on
declare -r HOST_NAME=$(uname -n | sed 's/\.ihr//') ;
# token separating arg to this script vs args to underlying script call
declare -r CMD_DELIM='--';
# sentinel to flag when we've hit the end of the script args.
declare -i DELIM_FOUND=0;
# output log file
declare STDOUT_FILE=
# error log file
declare STDERR_FILE=
# variable to capture the nagios status (OK|WARNING|CRITIAL)
declare NAG_STATUS

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
declare -r NSCA_CMD=/usr/lib/nagios/plugins/send_nsca;
[[ ! -x $NSCA_CMD ]] \
    && echo "${SCRIPT}: ERROR: send_nsca command not found or not executable (${NSCA_CMD})" \
    && exit 1;

# argument processing 
#loop through each arg until we hit the command delimiter
while [[ -n "${1}" && $DELIM_FOUND -eq 0 ]]; do 
    case $1 in 

        # nagios passive service name to report to
        -S | --service-name )
            shift;
            SVC_NM="${1}";
            shift;
            ;;

        # save standard output to given file
        -o | --out-log )
            shift;
            STDOUT_FILE=${1};
            shift;
            ;;

        # save standard error output to a given file 
        -e | --err-log )
            shift;
            STDERR_FILE=${1};
            shift;
            ;;

        # save BOTH stdout and stderr to a given file
        -L | --log-file )
            shift;
            STDOUT_FILE=${1};
            STDERR_FILE=${1};
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

# ensure we have the paths we need(?)
# @TODO look into whether or not this is necessary
PATH=$PATH:/bin:/usr/local/bin:/usr/bin:/sbin;
export PATH;


# if no out/err log specified, we create a tmp file to catch the output, then clean up on exit
if [ -z "${STDOUT_FILE}" ]; then
    STDOUT_FILE=$(mktemp --suffix=.nsca_relay.out);
    trap 'rm -rf $STDOUT_FILE' SIGINT SIGTERM EXIT;
fi

if [ -z "${STDERR_FILE}" ]; then
    STDERR_FILE=$(mktemp --suffix=.nsca_relay.err);
    trap 'rm -rf $STDERR_FILE' SIGINT SIGTERM EXIT;
fi

# execute the subcommands
$* >$STDOUT_FILE 2>$STDERR_FILE;
# save exit status
SUB_XSTAT=$?;

# determine nagios status string
case $SUB_XSTAT in
    0) NAG_STATUS='OK'; 
       ;;
    1) NAG_STATUS='WARNING'; 
       ;;
    2) NAG_STATUS='CRITICAL';
       ;;
    *) NAG_STATUS='ERROR: UNKNOWN STATUS LEVEL RETURNED FROM SUB COMMAND';
       ;;
esac

# report to nsca  
$NSCA_CMD -H $NAG_SVR -c $NSCA_CONF < <(echo -e "${HOST_NAME}\t${SVC_NM}\t${SUB_XSTAT}\t${NAG_STATUS}:$(cat $STDOUT_FILE)")
[[ $? -ne 0 ]] \
    && echo "${SCRIPT}: ERROR: Nonzero exit status reported from nsca command" \
    && exit 1;

# just relay exit status returned by subcommands 
exit ${SUB_XSTAT};

