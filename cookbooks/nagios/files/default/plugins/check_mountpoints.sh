#!/usr/bin/env bash
# #################################################
# @FILE: check_mountpoints.sh
# @AUTHOR: GregoryPatmore <gregorypatmore@clearchannel.com>}
# @CHEF-COOKBOOK: Nagios
# @PROJECT: Operations (OPS)
# @TICKETID: OPS-5746
# @TAB-SIZE: 4
# @SOFT-TABS: YES
# @DESC: Checks and verifies mountpoints
# @NOTES: 
# #################################################

# #################################################
# Variable Declarations
# #################################################

# Nagios standard states/exit statuses
# Indexed according to nagios exit status conventions
declare -a NAGIOS_STATE=(OK WARNING CRITICAL UNKNOWN);
declare -ri STATE_OK=0;
declare -ri STATE_WARNING=1;
declare -ri STATE_CRITICAL=2;
declare -ri STATE_UNKNOWN=3;

# array of field names in the various *_ENTRY arrays defined below
declare -a FIELDS=(device mountpoint fstype options dump fsckorder devsymlink);

# reference array to capture key names for the other arrays
declare -A MOUNT_IDS;
# assoc array of info from /etc/fstab
declare -A FSTAB_ENTRY;
# assoc array of info from /etc/mtab
declare -A MTAB_ENTRY;
# assoc array of info from /proc/mounts
declare -A PROC_ENTRY;
# assoc array of nagios states per mount
declare -A MOUNT_STATE;
# associative array of message info generated from checks
declare -A MOUNT_MSG;

# counters for end nagios states.
declare -A STATE_COUNTS;
STATE_COUNTS['OK']=0;
STATE_COUNTS['WARNING']=0;
STATE_COUNTS['UNKNOWN']=0;
STATE_COUNTS['CRITICAL']=0;


# #################################################
# Function Definitions
# #################################################



# converts a parsed entry string from one of the *_ENTRY arrays 
# and turns it into an associative array
# NOTE: use like so: eval "declare -A <variablename>=$(entry2array "<entrystring>")
#       example use: 
#         eval declare -A my_array=$(entry2array "</dev/sda8&&/home&&ext3&&rw,suid,dev,exec,auto,nouser,async&&1&&2&&/dev/disk/by-uuid/7b11992e-56b5-4b7d-8dad-17950e6b520d")
#         echo ${my_array['device']}; # outputs /dev/sda8
function entry2array(){
    local -A oa;
    local -a ia=(${*//&&/ });

    for i in ${!ia[*]}; do 
        oa[${FIELDS[$i]}]="${ia[$i]}";
    done;

    declare -p oa | sed -e 's/^declare -A oa=//';
};

# sets the mountpoint state to a given state unless the 
# current state is higher then given state, the higher state is retained.
function setMountState(){
    # echo "INFO: $0 : setMountState : $1 = $2"
    [ $# -ne 2 ] \
        && echo "ERROR: $0: setMountState : invalid usage. requires exactly 2 arguments <mountpoint> <state>" \
        && return 1;

    [ ${MOUNT_STATE[$1]+isset} ] || MOUNT_STATE[$1]=${STATE_OK};

    # make sure we received an integer
    if [[ $2 =~ ^[0-9]+$ ]] && [ ${NAGIOS_STATE[$2]+i} ]; then
        # echo "INFO: $0 : setMountState : received a valid nagios state integer";
        [[ $2 -gt ${MOUNT_STATE[$1]} ]] \
            && MOUNT_STATE[$1]=$2 \
            && return 0;


        # echo "INFO: $0 : setMountState : Given state does not supercede current state";
        return 0;
    else
        echo "ERROR: $0 : setMountState : invalid state received ($2) for mount ($1)"
    fi
};

# adds a message to the mountpoint message log 
function addMountMsg(){
    [ $# -ne 2 ] \
        && echo "ERROR: $0: addMountMsg : invalid usage. requires exactly 2 arguments <mountpoint> <message>" \
        && return 1;

    [ ! ${MOUNT_MSG[$1]+isset} ] && MOUNT_MSG[$1]='';

    MOUNT_MSG[$1]="${MOUNT_MSG[$1]}${2}\n";
    return 0;
};

# #################################################
# Information Discovery
# #################################################

# loop through each mount entry in fstab file
# index the various info gleaned from the other files
while read -r f_dev f_mp f_fs f_opt f_dmp f_fsck; do

    # if the device value conforms to the new redhat mounting conventions, 
    # we'll need to strip the prefix and make a correct path
    if grep -q 'UUID=' <<< $f_dev; then
        f_symdev="/dev/disk/by-uuid/${f_dev#UUID=}";
        f_dev=$(readlink -f $f_symdev);
    fi

    # normalize options set to 'default'
    [[ "${f_opt}" == "defaults" ]] \
        && f_opt="rw,suid,dev,exec,auto,nouser,async";

    # add an entry with device file into the main reference array
    MOUNT_IDS[${#MOUNT_IDS[*]}]=${f_mp};

    # set initial state to ok (0)
    MOUNT_STATE[${f_mp}]=STATE_OK;

    FSTAB_ENTRY[${f_mp}]="$f_dev&&$f_mp&&$f_fs&&$f_opt&&$f_dmp&&$f_fsck&&$f_symdev";
    # echo "FSTAB= dev:$f_dev, mp:$f_mp, fs:$f_fs, opt:$f_opt, dmp:$f_dmp, fsck:$f_fsck";

    # we'll mainly use the info in the fstab table,
    # however, we'll fetch the mtab and /proc/mounts 
    # info for reference

    # grab any records from the mtab file for reference
    read m_dev m_mp m_fs m_opt m_dmp m_fsck < <(grep "${f_mp}" /etc/mtab);
    MTAB_ENTRY[${f_mp}]="$m_dev&&$m_mp&&$m_fs&&$m_opt&&$m_dmp&&$m_fsck";
    #echo "MTAB=  dev:$m_dev, mp:$m_mp, fs:$m_fs, opt:$m_opt, dmp:$m_dmp, fsck:$m_fsck";

    # grab any records from /proc/mounts for reference
    read p_dev p_mp p_fs p_opt p_dmp p_fsck < <(grep "${f_mp}" /proc/mounts);
    PROC_ENTRY[${f_mp}]="$p_dev&&$p_mp&&$p_fs&&$p_opt&&$p_dmp&&$p_fsck";
    #echo "PROC=  dev:$p_dev, mp:$p_mp, fs:$p_fs, opt:$p_opt, dmp:$p_dmp, fsck:$p_fsck";

    #echo;

done < <( awk '/^[^#]/{print}' < /etc/fstab);

# #################################################
# Check Processing
# #################################################

for i in ${!FSTAB_ENTRY[*]}; do
    
    # echo "Running tests on $i";

    # set up the info as associative arrays so it's a bit easier.
    eval "declare -A fstab=$( entry2array ${FSTAB_ENTRY[$i]} )";
    eval "declare -A mtab=$( entry2array ${MTAB_ENTRY[$i]} )";
    eval "declare -A proc=$( entry2array ${PROC_ENTRY[$i]} )";

    # skip proc,swap,tmpfs,devpts,sysfs 
    # @TODO Write more checks for this(?) 
    grep -Eq "swap|devpts|tmpfs|proc" <<< ${fstab['fstype']} && continue;

    # make sure the mountpoint directory exists
    if [ -d ${fstab[mountpoint]} ]; then
        setMountState $i $STATE_OK;
        #echo "${fstab[mountpoint]} directory was found" >&2;
    else
        setMountState $i $STATE_CRITICAL;
        addMountMsg $i "Mountpoint directory missing.";
        #echo "ERROR: ${fstab[mountpoint]} directory is missing" >&2;
    fi

    # check options for read only. if not, make sure it's writable
    if [ ! $(echo "${fstab[mountpoint]}" | grep -Eq "[^0-9a-zA-Z]?ro[^0-9a-zA-Z]" ) ]; then

        # echo "INFO: $0 : Mount (${fstab[mountpoint]}) should be writable";
        # test by touching a tmp file
        r=$(timeout 5 touch ${fstab[mountpoint]}/.tmp.check_mountpoint.txt 2>/dev/null);
        rm -f ${fstab[mountpoint]}/.tmp.check_mountpoint.txt 2>/dev/null;

        if [[ $r -ne 0 ]]; then
            #echo "ERROR: $0 : Failed to touch a file" >&2;
            setMountState $i $STATE_CRITICAL;
            addMountMsg $i "Touch file check failed."
        else 
            #echo "INFO: $0 : Mountpoint (${fstab[mountpoint]}) is writable";
            setMountState $i $STATE_OK;
        fi    
    fi

    # check stat on nfs mounts
    if [ "${fstab[fstype]}" == 'nfs' ]; then
        r=$( read -t3 < <(stat -t $i) );
        if [ $? -eq 0 ]; then
            setMountState $i $STATE_OK;
        else 
            setMountState $i $STATE_CRITICAL;
            addMountMsg $i "Stat check failed for nfs mount";
        fi
    fi

done;

#count up the end mount states.
for i in ${!MOUNT_STATE[*]}; do
    # echo "$i , ${MOUNT_STATE[$i]}"
    case "${MOUNT_STATE[$i]}" in
        STATE_OK | 0) 
           ((STATE_COUNTS[OK]++));
           ;;
        STATE_WARNING | 1)
            ((STATE_COUNTS[WARNING]++));
            ;;
        STATE_UNKNOWN | 2)
            ((STATE_COUNTS[UNKNOWN]++));
            ;;
        STATE_CRITICAL | 3)
            ((STATE_COUNTS[CRITICAL]++));
            ;;
        *)
            echo "ERROR: $0 : Invalid state (${MOUNT_STATE[$i]}) found for mount ($i)";
            ;;
    esac
done;

# craft the information message and exit status;
if [ ${STATE_COUNTS[CRITICAL]} -gt 0 ]; then
    echo -n "CRITICAL C:${STATE_COUNTS[CRITICAL]},W:${STATE_COUNTS[WARNING]},U:${STATE_COUNTS[UNKNONW]},O:${STATE_COUNTS[OK]} | ";
    for i in ${!MOUNT_MSG[*]}; do
        echo -e "$i : ${MOUNT_MSG[$i]}";
    done;
    exit $STATE_CRITICAL;

elif [ ${STATE_COUNTS[WARNING]} -gt 0 ]; then
    echo -n "WARNING C:${STATE_COUNTS[CRITICAL]},W:${STATE_COUNTS[WARNING]},U:${STATE_COUNTS[UNKNONW]},O:${STATE_COUNTS[OK]} | ";
    for i in ${!MOUNT_MSG[*]}; do
        echo -e "$i : ${MOUNT_MSG[$i]}";
    done;
    exit $STATE_WARNING;

elif [ ${STATE_COUNTS[UNKNOWN]} -gt 0 ]; then
    echo -n "UNKNOWN C:${STATE_COUNTS[CRITICAL]},W:${STATE_COUNTS[WARNING]},U:${STATE_COUNTS[UNKNONW]},O:${STATE_COUNTS[OK]} | ";
    for i in ${!MOUNT_MSG[*]}; do
        echo -e "$i : ${MOUNT_MSG[$i]}";
    done;
    exit $STATE_UNKNOWN;
else
    echo -n "OK C:${STATE_COUNTS[CRITICAL]},W:${STATE_COUNTS[WARNING]},U:${STATE_COUNTS[UNKNONW]},O:${STATE_COUNTS[OK]} | ";
    for i in ${!MOUNT_MSG[*]}; do
        echo -e "$i : ${MOUNT_MSG[$i]}";
    done;
    exit $STATE_OK;
fi




# #################################################
# Debugging Output
# #################################################


# echo "STATE COUNTS:" 
# for i in ${!STATE_COUNTS[*]}; do
#     echo  "$i = ${STATE_COUNTS[$i]}";
# done;
# echo;


# echo "STATE INFO"
# for i in ${!MOUNT_STATE[*]}; do
#     echo  -n "$i = ";
#     echo "${NAGIOS_STATE[${MOUNT_STATE[$i]}]}";
# done;
# echo;

# echo "STATE Messages"
# for i in ${!MOUNT_MSG[*]}; do
#     echo "$i";
#     echo -e "${MOUNT_MSG[$i]}";
# done;
# echo;

# echo "Valid States: ${NAGIOS_STATE[*]}";
# echo "Mounts: ${MOUNT_IDS[*]}";
# echo

# echo "FSTAB INFO"
# for i in ${!FSTAB_ENTRY[*]}; do
#     echo  -n "$i = ";
#     echo "${FSTAB_ENTRY[$i]//&&/ : }";
# done;
# echo;

# echo "MTAB INFO"
# for i in ${!MTAB_ENTRY[*]}; do
#     echo  -n "$i = ";
#     echo "${MTAB_ENTRY[$i]//&&/ : }";
# done;
# echo;

# echo "PROC INFO"
# for i in ${!PROC_ENTRY[*]}; do
#     echo  -n "$i = ";
#     echo "${PROC_ENTRY[$i]//&&/ : }";
# done;
# echo;

# echo "Testing entry2array";
# echo;
# echo "TESTING FSTAB FOR: /home";
# eval "declare -A f=$( entry2array ${FSTAB_ENTRY['/home']} )";
# for i in ${!f[*]}; do
#     echo  -n "$i = ";
#     echo "${f[$i]}";
# done;
# echo;

# echo "TESTING MTAB FOR: /home";
# eval "declare -A f=$( entry2array ${MTAB_ENTRY['/home']} )";
# for i in ${!f[*]}; do
#     echo  -n "$i = ";
#     echo "${f[$i]}";
# done;
# echo;

# echo "TESTING PROC FOR: /home";
# eval "declare -A f=$( entry2array ${PROC_ENTRY['/home']} )";
# for i in ${!f[*]}; do
#     echo  -n "$i = ";
#     echo "${f[$i]}";
# done;
# echo;


