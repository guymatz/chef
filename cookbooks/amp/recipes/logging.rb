#
# Cookbook Name:: amp
# Recipe:: logging
#
# Copyright 2013, iHeartRadio
#
# All rights reserved - Do Not Redistribute
#
# @CHANGELOG: 
# - 8/5/13 GP Added in another amp extended log 500 rate check
# ################################################

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


# gp edit 8/5/13 ref JIRA:OPS-4922
template "#{node[:amp][:logging][:script_path]}/amp-extended-log-chk.sh" do
  source "amp-extended-log-chk.sh.erb"
  owner node[:amp][:logging][:user]
  group node[:amp][:logging][:group]
  mode "0755"
end

# GP 9/24/13 - updated. replaced cronwrap command with nsca_relay
cron_d "amp-extended-log-chk" do
  minute "*/5"
  command "/usr/bin/nsca_relay -S amp-extended-log-chk -- #{node[:amp][:logging][:script_path]}/amp-extended-log-chk.sh 2>&1 >> #{node[:amp][:logging][:log_path]}/amp-extended-log-chk.log"
end
#END gp edit

# GP 9/24/13 - updated. replaced cronwrap command with nsca_relay
cron_d "amp-extended-log" do
  minute "*/5"
  command "/usr/bin/nsca_relay -S amp-extended-log -- #{node[:amp][:logging][:script_path]}/extended-api-log.sh 2>&1 >> #{node[:amp][:logging][:log_path]}/api-errors.log"
  #user node[:amp][:logging][:user]
end


cron_d "amp-log-purger" do
  minute "35"
  hour "4"
  command "find #{node[:amp][:logging][:log_path]} -name '*.log' -mtime +14 -exec rm -rf {} \\;"
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
  minute "0"
  hour "2"
  command "#{node[:amp][:logging][:script_path]}/tomcat-rotate.sh"
  #user node[:amp][:logging][:user]
end
