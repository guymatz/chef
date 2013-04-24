#!/bin/sh
export PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin

tar cvjf /data/log/playlog/processed/processed_playlogs_10.90.40.6_`/bin/date +'\%H-\%d-\%m-\%Y'.tar.bz2` `/usr/bin/find /data/log/playlog/processed/ -name 'stream*' -mmin +120`; /usr/bin/find /data/log/playlog/processed/ -name 'stream*' -mmin +120 -exec rm -f {} \;

tar cvjf /data/log/talkplaylog/processed/processed_talkplaylogs_10.90.40.6_`/bin/date +'\%H-\%d-\%m-\%Y'.tar.bz2` `/usr/bin/find /data/log/talkplaylog/processed/ -name 'stream*' -mmin +120`; /usr/bin/find /data/log/talkplaylog/processed/ -name 'stream*' -mmin +120 -exec rm -f {} \;

tar cvjf /data/log/customradiothumbslog/processed/processed_customthumbslogs_10.90.40.6_`/bin/date +'\%H-\%d-\%m-\%Y'.tar.bz2` `/usr/bin/find /data/log/customradiothumbslog/processed/ -name -mmin +120`; /usr/bin/find /data/log/customradiothumbslog/processed/ -mmin +120 -exec rm -f {} \;

tar cvjf /data/log/liveradiothumbslog/processed/processed_livethumbslogs_10.90.40.6_`/bin/date +'\%H-\%d-\%m-\%Y'.tar.bz2` `/usr/bin/find /data/log/liveradiothumbslog/processed/ -name -mmin +120`; /usr/bin/find /data/log/liveradiothumbslog/processed/ -mmin +120 -exec rm -f {} \;

find /data/log/talkplaylog/processed -name '*.tar.bz2' -mtime +1 -exec mv {} /isilon/talkplaylog/processed/ \;
find /data/log/playlog/processed -name '*.tar.bz2' -mtime +1 -exec mv {} /isilon/playlog/processed/ \;
