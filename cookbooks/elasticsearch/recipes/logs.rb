
logrotate_app "elastic" do
  cookbook "logrotate"
  path "#{node[:elasticsearch][:deploy_path]}/*/logs/" do
  options ["missingok", "delaycompress", "notifempty", "copytruncate"]
  frequency "daily"
  enable true
  create "0644 nobody root"
  rotate 1
end


logrotate_app "elastic-corpus" do
  cookbook "logrotate"
  path "#{node[:elasticsearch][:deploy_path]}/*/logs-*/" do
  options ["missingok", "delaycompress", "notifempty", "copytruncate"]
  frequency "daily"
  enable true
  create "0644 nobody root"
  rotate 1
end
