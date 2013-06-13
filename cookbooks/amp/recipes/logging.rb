#
# Cookbook Name:: amp
# Recipe:: logging
#
# Copyright 2013, iHeartRadio
#
# All rights reserved - Do Not Redistribute
#

directory node[:amp][:logging][:script_path] do
  owner node[:amp][:logging][:user]
  group node[:amp][:logging][:group]
  recursive true
end

directory node[:amp][:logging][:log_path] do
  owner node[:amp][:logging][:user]
  group node[:amp][:logging][:group]
  recursive true
end

template "#{node[:amp][:logging][:script_path]}/extended-api-log.sh" do
  source "extended-api-log.sh.erb"
  owner node[:amp][:logging][:user]
  group node[:amp][:logging][:group]
  mode "0755"
  variables({
              :script_dir => node[:amp][:logging][:script_path],
              :log_dir => node[:amp][:logging][:log_path]
            })
end

template "#{node[:amp][:logging][:script_path]}/extended-log.sh" do
  source "extended-log.sh.erb"
  owner node[:amp][:logging][:user]
  group node[:amp][:logging][:group]
  mode "755"
  variables({
              :script_dir => node[:amp][:logging][:script_path],
              :tomcat_dir => node[:tomcat7][:install_path]
            })
end

template "#{node[:amp][:logging][:script_path]}/api-logs.py" do
  source "api-logs.py.erb"
  owner node[:amp][:logging][:user]
  group node[:amp][:logging][:group]
  mode "0755"
end

template "#{node[:amp][:logging][:script_path]}/apiparse.py" do
  source "apiparse.py.erb"
  owner node[:amp][:logging][:user]
  group node[:amp][:logging][:group]
  mode "0755"
end

cron_d "amp-extended-log" do
  minute "*/5"
  command "cronwrap #{node[:hostname]} amp-extended-log \"#{node[:amp][:logging][:script_path]}/extended-api-log.sh\" 2>&1 >> #{node[:amp][:logging][:log_path]}/api-errors.log"
  #user node[:amp][:logging][:user]
end

cron_d "amp-log-purger" do
  minute "35"
  hour "4"
  command "find #{node[:amp][:logging][:log_path]} -name '*.log*' -mtime +14 -exec rm -rf {} \\;"
  #user node[:amp][:logging][:user]
end

template "#{node[:amp][:logging][:script_path]}/tomcat-rotate.sh" do
  source "tomcat-rotate.sh.erb"
  owner node[:amp][:logging][:user]
  group node[:amp][:logging][:group]
  mode "755"
  variables({
              :tomcat_dir => node[:tomcat7][:install_path]
            })
end

cron_d "amp-rotate-tomcat-logs" do
  hour "2"
  command "#{node[:amp][:logging][:script_path]}/tomcat-rotate.sh"
  #user node[:amp][:logging][:user]
end
