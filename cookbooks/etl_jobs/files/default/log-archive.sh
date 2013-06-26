#!/bin/sh
export PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin

PIDFILE=/var/run/log-archive.pid
if [ -f $PIDFILE ] ; then
    echo "Already running: $PIDFILE"
fi

echo $$ > $PIDFILE

echo -ne "Begining playlog at $(date)"
FILES=$(/usr/bin/find /data/log/playlog/processed/ -name 'stream*')
nice -n 19 tar czf /data/log/playlog/processed/processed_playlogs_10.5.1.36_$(/bin/date +%H-%M-%d-%m-%Y).tar.gz $FILES
rm -f $FILES
echo -ne "Done with playlog at $(date)"

echo -ne "Begining talkplaylog at $(date)"
FILES=$(/usr/bin/find /data/log/talkplaylog/processed/ -name 'stream*')
nice -n 19 tar czf /data/log/talkplaylog/processed/processed_talkplaylogs_10.5.1.36_$(/bin/date +%H-%M-%d-%m-%Y).tar.gz $FILES
rm -f $FILES
echo -ne "Done with playlog at $(date)"

echo -ne "Begining customradio at $(date)"
FILES=$(/usr/bin/find /data/log/customradiothumbslog/processed/ -name 'customradioevent*')
nice -n 19 tar czf /data/log/customradiothumbslog/processed/processed_customthumbslogs_10.5.1.36_$(/bin/date +%H-%M-%d-%m-%Y).tar.gz $FILES
rm -f $FILES
echo -ne "Done with playlog at $(date)"

echo -ne "Begining liveradio at $(date)"
FILES=$(/usr/bin/find /data/log/liveradiothumbslog/processed/ -name 'liveradioevent*')
nice -n 19 tar czf /data/log/liveradiothumbslog/processed/processed_livethumbslogs_10.5.1.36_$(/bin/date +%H-%M-%d-%m-%Y).tar.gz $FILES
rm -f $FILES
echo -ne "Done with playlog at $(date)"

echo -ne "Begining sysinfo at $(date)"
FILES=$(/usr/bin/find /data/log/sysinfo/processed/ -name 'iad*')
nice -n 19 tar czf /data/log/sysinfo/processed/processed_sysinfologs_10.5.1.36_$(/bin/date +%H-%M-%d-%m-%Y).tar.gz $FILES
rm -f $FILES
echo -ne "Done with sysinfo at $(date)"

echo -ne "Begining event at $(date)"
FILES=$(/usr/bin/find /data/log/event/processed/ -name 'iad*')
nice -n 19 tar czf /data/log/event/processed/processed_eventlogs_10.5.1.36_$(/bin/date +%H-%M-%d-%m-%Y).tar.gz $FILES
rm -f $FILES
echo -ne "Done with event at $(date)"

echo -ne "Deleting older files"
/usr/bin/find /data/log/*/processed/ -mtime +4 -exec rm {} \;
echo -ne "Done deleting older files at $(date)"

#nice -n 19 find /data/log/talkplaylog/processed -name '*.tar.gz' -mtime +1 -exec mv {} /isilon/talkplaylog/processed/ \;
#nice -n 19 find /data/log/playlog/processed -name '*.tar.gz' -mtime +1 -exec mv {} /isilon/playlog/processed/ \;

rm -f $PIDFILE
