#!/usr/bin/env bash
. /usr/local/ipplan/bin/update.conf

rm -f $WORKDIR/*.{xml,zone,fake}
rm -rf $WORKDIR/git.*
rm -f $STAGING/*.{xml,zone,fake}