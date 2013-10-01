cron_d "backup-elasticsearch" do
  command "rsync -az #{node[:elasticsearchnew][:ihrsearch_path]}/data #{node[:elasticsearchnew][:backup_server]}:#{node[:elasticsearchnew][:backup_target]}/$(date +%Y%m%d)/${HOSTNAME}"
  minute "0"
  hour "0"
  user "root"
end
