
puts "WHATTHEFUCK"
if node.run_list.include?("role[loghost]")
  puts "DURKADURKA"
  file "/etc/rsyslog.d/05-search-exit.conf" do
    action :create_if_missing
    owner "root"
    group "root"
    mode "0755"
    content <<-EOH
$template DynaFile,"#{node[:rsyslog][:log_dir]}/%$YEAR%%$MONTH%%$DAY%/apps/%PROGRAMNAME%/%HOSTNAME%.log"
if $programname startswith 'search-exit' then -?DynaFile
&~
EOH
    only_if "test -d /etc/rsyslog.d"
    notifies :reload, "service[rsyslog]"
  end
  template "/etc/rsyslog.d/05-amp-access-log.conf" do
    source "access-logs.conf.server.erb"
    owner "root"
    group "root"
    mode "0755"
    notifies :restart, "service[rsyslog]"
  end
elsif node.run_list.include?("role[amp-logger]")
  template "/etc/rsyslog.d/search-exit.conf" do
    source "search-exit.conf.client.erb"
    owner "root"
    group "root"
    mode "0755"
    variables({
                :tomcat_dir => node[:tomcat7][:install_path]
              })
    notifies :restart, "service[rsyslog]"
  end
elsif node.run_list.include?("role[amp]")
  puts "IMANAMP"
  template "/etc/rsyslog.d/amp-access-logs.conf" do
    source "access-logs.conf.client.erb"
    owner "root"
    group "root"
    mode "0755"
    variables({
                :tomcat_dir => node[:tomcat7][:install_path]
              })
    notifies :restart, "service[rsyslog]"
  end
else
  puts "TOTALFUCKUP"
  puts node.run_list.inspect
end

