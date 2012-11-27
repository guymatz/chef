#!/usr/bin/env bash
set -x


cd /staging_bind/named/
res=$(git pull)
if [[  "$res" == "Already up-to-date." ]] ; then
    echo "no changes to sync"
else
    cp -r * /var/named/chroot/var/named/
    /etc/init.d/named restart
fi

if [ "$1" == "force" ] ; then
    echo "forcing file copy and named restart"
    cp -r * /var/named/chroot/var/named/
    /etc/init.d/named restart
fi

