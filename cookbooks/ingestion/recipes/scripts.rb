directory "/root/scripts" do
  owner "root"
  group "root"
  mode "0755"
end

cookbook_file "/root/scripts/check_ingdb_data_backup_corruption.sh" do
  owner "root"
  group "root"
  mode "0755"
end

cron "check_ingdb_data_backup_corruption" do
  command "/root/scripts/check_ingdb_data_backup_corruption.sh"
  minute  "45"
  hour	  "0"
  month	  "*"
  weekday "*"
end

cookbook_file "/root/scripts/check_ingdb_index_backup_corruption.sh" do
  owner "root"
  group "root"
  mode "0755"
end

cron "check_ingdb_index_backup_corruption" do
  command "/root/scripts/check_ingdb_index_backup_corruption.sh"
  minute  "45"
  hour    "1"
  month   "*"
  weekday "*"
end

cookbook_file "/root/scripts/check_ingdb_archwal_backup_corruption.sh" do
  owner "root"
  group "root"
  mode "0755"
end

cron "check_ingdb_archwal_backup_corruption" do
  command "/root/scripts/check_ingdb_archwal_backup_corruption.sh"
  minute  "45"
  hour    "2"
  month   "*"
  weekday "*"
end

cron "check_ingdb_backup_freshness" do
  command "/root/scripts/check_ingdb_backup_freshness.sh"
  minute  "25"
  hour    "3"
  month   "*"
  weekday "*"
end

cookbook_file "/root/scripts/check_ingdb_backup_freshness.sh" do
  owner "root"
  group "root"
  mode "0755"
end

cron "check_ingdb_backup_size" do
  command "/root/scripts/check_ingdb_backup_size.sh"
  minute  "25"
  hour    "2"
  month   "*"
  weekday "*"
end

cookbook_file "/root/scripts/check_ingdb_backup_size.sh" do
  owner "root"
  group "root"
  mode "0755"
end
