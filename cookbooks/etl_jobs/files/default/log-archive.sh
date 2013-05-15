#!/bin/sh
export PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin

nice -n 19 tar czf /data/log/playlog/processed/processed_playlogs_10.90.40.6_`/bin/date +'\%H-\%d-\%m-\%Y'.tar.gz` `/usr/bin/find /data/log/playlog/processed/ -name 'stream*' -mmin +120`;nice -n 19 /usr/bin/find /data/log/playlog/processed/ -name 'stream*' -mmin +120 -exec rm -f {} \;

nice -n 19 tar czf /data/log/talkplaylog/processed/processed_talkplaylogs_10.90.40.6_`/bin/date +'\%H-\%d-\%m-\%Y'.tar.gz` `/usr/bin/find /data/log/talkplaylog/processed/ -name 'stream*' -mmin +120`;nice -n 19 /usr/bin/find /data/log/talkplaylog/processed/ -name 'stream*' -mmin +120 -exec rm -f {} \;

nice -n 19 tar czf /data/log/customradiothumbslog/processed/processed_customthumbslogs_10.90.40.6_`/bin/date +'\%H-\%d-\%m-\%Y'.tar.gz` `/usr/bin/find /data/log/customradiothumbslog/processed/ -name -mmin +120`; /usr/bin/find /data/log/customradiothumbslog/processed/ -mmin +120 -exec rm -f {} \;

nice -n 19 tar czf /data/log/liveradiothumbslog/processed/processed_livethumbslogs_10.90.40.6_`/bin/date +'\%H-\%d-\%m-\%Y'.tar.gz` `/usr/bin/find /data/log/liveradiothumbslog/processed/ -name -mmin +120`; /usr/bin/find /data/log/liveradiothumbslog/processed/ -mmin +120 -exec rm -f {} \;

#nice -n 19 find /data/log/talkplaylog/processed -name '*.tar.gz' -mtime +1 -exec mv {} /isilon/talkplaylog/processed/ \;
#nice -n 19 find /data/log/playlog/processed -name '*.tar.gz' -mtime +1 -exec mv {} /isilon/playlog/processed/ \;
