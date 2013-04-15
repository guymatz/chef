#
# Cookbook Name:: fac
# Recipe:: talk
#
# Copyright 2013, iHeartRadio
#
# All rights reserved - Do Not Redistribute
#
app = "talk"
download_url = "#{node[:fac][:url]}/FAC-#{app}/#{node[:fac][app][:version]}/FAC-#{app}-#{node[:fac][app][:version]}.jar"
script_dir = "#{node[:fac][:script_path]}/#{app}"

directory "#{script_dir}" do
  recursive true
end

remote_file "#{script_dir}/fac-#{app}.jar" do
  Chef::Log.info("Downloading fac-#{app} from #{download_url}")
  source "#{download_url}"
  mode "0755"
end

# init directories
%w{ /var/run/fac }.each do |dir|
  directory dir do
    recursive true
    mode "0755"
  end
end

template "/etc/init.d/fac-#{app}" do
  source "fac.init.erb"
  mode "0755"
  owner "root"
  group "root"
  variables({
              :fac_app => app,
              :jarfile => "#{script_dir}/fac-#{app}.jar"
            })
end
