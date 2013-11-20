#
# Cookbook Name:: fac
# Recipe:: recommendations   (apadted from sherpa)
# Copyright 2013, iHeartRadio
# All rights reserved - Do Not Redistribute
#
app = "recommendations"
jar_file = "FAC-#{app}-#{node[:fac][app][:version]}.jar"
download_url = "#{node[:fac][:url]}/FAC-#{app}/#{node[:fac][app][:version]}/#{jar_file}"
script_dir = "#{node[:fac][:script_path]}/#{app}"
start_script = "fac-#{app}-runner.sh"

directory "#{script_dir}" do
  recursive true
end

remote_file "#{script_dir}/#{jar_file}" do
  Chef::Log.info("Downloading #{download_url}")
  source "#{download_url}"
  mode "0755"
  action :create_if_missing
end

link "#{script_dir}/fac-#{app}.jar" do
  to "#{script_dir}/#{jar_file}" 
end

# init directories
%w{ /var/run/fac }.each do |dir|
  directory dir do
    recursive true
    mode "0755"
  end
end

directory "/var/log/fac-recs/fac-#{app}" do
  recursive true
  mode "0755"
end

template "#{script_dir}/#{start_script}" do
  source "#{start_script}.erb"
  mode "0755"
  owner "root"
  group "root"
  variables({
    :jarfile => "#{script_dir}/#{jar_file}"
  })
end

#nagios_nrpecheck "FAC-Recommendations" do
#  command "#{node['nagios']['plugin_dir']}/check_procs"
#  warning_condition "1:1"
#  critical_condition "1:1"
#  parameters "-C fac-recommendations.jar" 
#  action :add
#end

cron_d "remove-recommendation-logs" do
  minute 0
  hour 3
  command "rm -f /var/log/fac-recs/fac-recs-#{app}/*log.*"
end

cron_d "fac-recommendations" do
 minute "12"
 hour "12"
 command "/usr/bin/nsca_relay -S fac-recommendations -- #{script_dir}/#{start_script}"
 user "root"
end

