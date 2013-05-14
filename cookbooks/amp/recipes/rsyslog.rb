
file "/etc/rsyslog.d/05-search-exit.conf" do
  action :create_if_missing
  owner "root"
  group "root"
  mode "0755"
  content <<-EOH
$template DynaFile,"#{node[:rsyslog][:log_dir]}/%$YEAR%/%$MONTH%/%$DAY%/%HOSTNAME%/%PROGRAMNAME%.log"
if $programname startswith 'search-exit' then -?DynaFile
&~
EOH
  only_if "test -d /etc/rsyslog.d"
  notifies :reload, "service[rsyslog]"
end
