directory "/root/scripts" do
  owner "root"
  group "root"
  mode "0755"
end

cookbook_file "/root/scripts/check_authdb_data_backup_corruption.sh" do
  owner "root"
  group "root"
  mode "0755"
end

cron "check_authdb_data_data_backup_corruption" do
  command "/root/scripts/check_authdb_data_backup_corruption.sh"
  minute  "45"
  hour	  "0"
  month	  "*"
  weekday "*"
  mailto "CCRDDatabaseOperations@clearchannel.com"
end

cookbook_file "/root/scripts/check_authdb_index_backup_corruption.sh" do
  owner "root"
  group "root"
  mode "0755"
end

cron "check_authdb_index_backup_corruption" do
  command "/root/scripts/check_authdb_index_backup_corruption.sh"
  minute  "45"
  hour    "1"
  month   "*"
  weekday "*"
  mailto "CCRDDatabaseOperations@clearchannel.com"
end

cookbook_file "/root/scripts/check_authdb_archwal_backup_corruption.sh" do
  owner "root"
  group "root"
  mode "0755"
end

cron "check_authdb_archwal_backup_corruption" do
  command "/root/scripts/check_authdb_archwal_backup_corruption.sh"
  minute  "45"
  hour    "2"
  month   "*"
  weekday "*"
  mailto "CCRDDatabaseOperations@clearchannel.com"
end

cron "check_authdb_backup_freshness" do
  command "/root/scripts/check_authdb_backup_freshness.sh"
  minute  "25"
  hour    "3"
  month   "*"
  weekday "*"
  mailto "CCRDDatabaseOperations@clearchannel.com"
end

cookbook_file "/root/scripts/check_authdb_backup_freshness.sh" do
  owner "root"
  group "root"
  mode "0755"
end

cron "check_authdb_backup_size" do
  command "/root/scripts/check_authdb_backup_size.sh"
  minute  "25"
  hour    "2"
  month   "*"
  weekday "*"
  mailto "CCRDDatabaseOperations@clearchannel.com"
end

cookbook_file "/root/scripts/check_authdb_backup_size.sh" do
  owner "root"
  group "root"
  mode "0755"
end
