node[:ingestion][:scripts][:packages].each do |p|
  package p
end

crond "rsync_wals" do
  action	:create
  minute 	"*"
  hour   	"*"
  day    	"*"
  weekday	"*"
  command	"/usr/bin/rsync -a 10.90.47.180:/u05/pg/archwal/* /data/wal"
  mailto	"CCRDDatabaseOperations@clearchannel.com"
  user		"postgres"
end

crond "kill_idle" do
  minute	"0,10,20,30,40,50"
  hour		"*"
  day		"*"
  weekday	"*"
  command	"/home/postgres/scripts/kill-idling-connections.sh appbatchuser 60 > /home/postgres/scripts/logs/killedsession.log 2>&1"
  mailto        "CCRDDatabaseOperations@clearchannel.com"
  user		"postgres"
end

crond "clean_pg_log" do
  minute        "0"
  hour          "0"
  day           "*"
  weekday       "*"
  command       "find /data/dbdata/pg_log/ -name \"*.log\" -mtime +100 | xargs rm -f"
  mailto        "CCRDDatabaseOperations@clearchannel.com"
  user		"postgres"
end

crond "generate_pg_log_report" do
  minute        "58"
  hour          "23"
  day           "*"
  weekday       "*"
  command       "/home/postgres/scripts/sql-reports/generate-pglog-report.sh iad-ing101 /data/dbdata/pg_log"
  mailto        "CCRDDatabaseOperations@clearchannel.com"
  user		"postgres"
end

crond "vacuum_analyze_pgfouine" do
  minute        "3"
  hour          "0,7,14,18"
  day           "*"
  weekday       "*"
  command       "/home/postgres/scripts/vacuum_analyze_pgfouine.sh"
  mailto        "CCRDDatabaseOperations@clearchannel.com"
  user		"postgres"
end

crond "vacuum_analyze_pgfouine" do
  minute        "3"
  hour          "0,7,14,18"
  day           "*"
  weekday       "*"
  command       "/home/postgres/scripts/vacuum_analyze_pgfouine.sh"
  mailto        "CCRDDatabaseOperations@clearchannel.com"
  user		"postgres"
end

crond "reindex_system_catalogs" do
  minute        "0"
  hour          "1"
  day           "*"
  weekday       "*"
  command       "/home/postgres/scripts/reindex_system.sh"
  mailto        "CCRDDatabaseOperations@clearchannel.com"
  user          "postgres"
end

crond "online_backup" do
  minute        "0"
  hour          "3"
  day           "*"
  weekday       "0,3,5"
  command       "/home/postgres/scripts/do_online_backup.sh > /home/postgres/onlinebackup.log 2>&1"
  mailto        "CCRDDatabaseOperations@clearchannel.com"
  user          "postgres"
end

crond "rotate_archived_wals" do
  minute        "5,37"
  hour          "*"
  day           "*"
  weekday       "*"
  command       "/home/postgres/scripts/rotate_archived_wals.sh >> /home/postgres/scripts/logs/rotate_arch_wal.log 2>&1"
  mailto        "CCRDDatabaseOperations@clearchannel.com"
  user          "postgres"
end

crond "log_file_monitor" do
  minute        "*/5"
  hour          "*"
  day           "*"
  weekday       "*"
  command       "/home/postgres/scripts/LogFileMonitor.sh 5 \"/data/dbdata/pg_log/postgresql*\" > /dev/null"
  mailto        "CCRDDatabaseOperations@clearchannel.com"
  user          "postgres"
end
