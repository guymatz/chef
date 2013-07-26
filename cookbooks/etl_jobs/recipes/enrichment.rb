

directory node[:enrichment][:appdir] do
  owner node[:enrichment][:log][:user]
  group node[:enrichment][:log][:user]
  recursive true
end

template "#{node[:enrichment][:appdir]}/sync-enrichment-logs.sh" do
  owner node[:enrichment][:log][:user]
  group node[:enrichment][:log][:user]
  source "sync-enrichment-logs.sh.erb"
  mode "0755"
end

cron_d "etl-enrichment-rsync-logs" do
  user node[:enrichment][:log][:user]
  mailto node[:admin_email]
  min "0"
  hour "5"
  command "/usr/bin/cronwrap use1b-jobserver101a sync-enrichment \"#{node[:enrichment][:appdir]}/sync-enrichment-logs.sh\""
end
