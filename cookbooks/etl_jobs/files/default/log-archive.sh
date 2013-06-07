#!/bin/sh
export PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin

PIDFILE=/var/run/log-archive.pid
if [ -f $PIDFILE ] ; then
    echo "Already running: $PIDFILE"
fi

echo $$ > $PIDFILE

echo -ne "Begining playlog at $(date)"
FILES=$(/usr/bin/find /data/log/playlog/processed/ -name 'stream*')
tar czf /data/log/playlog/processed/processed_playlogs_10.90.40.6_$(/bin/date +%H-%M-%d-%m-%Y).tar.gz $FILES
rm -rf $FILES
echo -ne "Done with playlog at $(date)"

echo -ne "Begining talkplaylog at $(date)"
FILES=$(/usr/bin/find /data/log/talkplaylog/processed/ -name 'stream*')
tar czf /data/log/talkplaylog/processed/processed_talkplaylogs_10.90.40.6_$(/bin/date +%H-%M-%d-%m-%Y) $FILES
rm -rf $FILES
echo -ne "Done with playlog at $(date)"

echo -ne "Begining customradio at $(date)"
FILES=$(/usr/bin/find /data/log/customradiothumbslog/processed/)
tar czf /data/log/customradiothumbslog/processed/processed_customthumbslogs_10.90.40.6_$(/bin/date +%H-%M-%d-%m-%Y) $FILES
rm -rf $FILES
echo -ne "Done with playlog at $(date)"

echo -ne "Begining liveradio at $(date)"
FILES=$(/usr/bin/find /data/log/liveradiothumbslog/processed/)
tar czf /data/log/liveradiothumbslog/processed/processed_livethumbslogs_10.90.40.6_$(/bin/date +%H-%M-%d-%m-%Y) $FILES
rm -rf $FILES
echo -ne "Done with playlog at $(date)"

echo -ne "Deleting older files"
/usr/bin/find data/log/*/processed/ -mtime +10 -delete
echo -ne "Done deleting older files at $(date)"

#nice -n 19 find /data/log/talkplaylog/processed -name '*.tar.gz' -mtime +1 -exec mv {} /isilon/talkplaylog/processed/ \;
#nice -n 19 find /data/log/playlog/processed -name '*.tar.gz' -mtime +1 -exec mv {} /isilon/playlog/processed/ \;

rm -f $PIDFILE
