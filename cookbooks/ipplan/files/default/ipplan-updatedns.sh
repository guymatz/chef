#!/bin/env bash

$(/bin/bash -n $0 >> /dev/null 2>&1)
if [ $? -ne 0 ]; then
        $(/bin/bash -n $0)
        echo
        echo "This script has syntax errors, try again!"
        echo; exit 255
fi


THIS_SCRIPT=$(basename $0)
export IPPLANROOT=/usr/local/ipplan
export DEBUGFILE=$IPPLANROOT/tmp/ipplan-updatedns-debug.$$

. $IPPLANROOT/bin/update.conf
. $IPPLANROOT/bin/ipplan-updatefunc.sh

if [ "$DEBUG" ]; then
    echo "DEBUG: is ON!! ($DEBUG)"
    echo "DEBUG: STAMP: $STAMP"
    echo "DEBUG: ZONE(s): $ZONES"
    echo "DEBUG: WORKDIR: $WORKDIR"
else
    DEBUG=0
fi

echo "Cleaning up possible xml turds"
rm -f $WORKDIR/*.{xml,zone,fake}
for ZONE in $ZONES; do
    echo "Exporting FWD-DNS from IPplan for zone: $ZONE"
    $EXPORTDNS 121 "$ZONE"
done
echo "Exporting REV-DNS from IPplan"
$EXPORTDNS 131

preflight_check
if [ $RETVAL -ne 0 ]; then
    [ "$DEBUG" -gt 0 ] && echo "ERROR: preflight failure. Exiting."
    exit $RETVAL
fi
[ "$DEBUG" -gt 0 ] && echo "DEBUG: executing xsltforwardzone"
xsltforwardzone
[ "$DEBUG" -gt 0 ] && echo "DEBUG: executing xsltreversezone"
xsltreversezone


## bindcheck: assure changes are syntactically correct
## $ROOTDIR/var/named/internal/$ZONE.$FILETAG.zone

for ZONE in $ZONES ; do
    [ "$DEBUG" -gt 0 ] && echo "DEBUG: executing bindcheckFWD on zone: $ZONE"
    bindcheckfwd
    [ "$DEBUG" -gt 0 ] && echo "DEBUG: retval after bindcheck: $RETVAL"
done
for ZONEFILE in $ALL_REV_ZONES
do
    ZONE=$(echo $ZONEFILE | cut -f2 -d '_')
    [ "$DEBUG" -gt 0 ] && echo "DEBUG: executing bindcheckREV on zone: $ZONE"
    bindcheckrev
    [ "$DEBUG" -gt 0 ] && echo "DEBUG: retval after bindcheck: $RETVAL"
done    

# everything has worked thus far, lets commit it
commit_changes

if [ "$DEBUG" -gt 0 ] ; then
    echo "DEBUG: not cleaning up in debug mode"
else
    cleanup
fi

[ "$DEBUG" -gt 0 ] && echo "DEBUG: exiting $RETVAL"
exit $RETVAL
