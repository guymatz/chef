#
# Cookbook Name:: fac
# Recipe:: music
#
# Copyright 2013, iHeartRadio
#
# All rights reserved - Do Not Redistribute
#

# this is to setup keys for shipping files
include_recipe "attivio::users"

app = "music"
download_url = "#{node[:fac][:url]}/FAC-#{app}/#{node[:fac][app][:version]}/FAC-#{app}-#{node[:fac][app][:version]}.jar"
script_dir = "#{node[:fac][:script_path]}/#{app}"

directory "#{script_dir}" do
  recursive true
end

%w{ attivio/add/artist attivio/add/bundle attivio/add/track
attivio/delete/artist attivio/delete/bundle /attivio/delete/track
fac_music }.each do |dir|
  directory "#{script_dir}/#{dir}" do
    recursive true
  end
end

remote_file "#{script_dir}/fac-#{app}.jar" do
  Chef::Log.info("Downloading fac-#{app} from #{download_url}")
  source "#{download_url}"
  mode "0755"
  action :create_if_missing
end

# init directories
%w{ /var/run/fac }.each do |dir|
  directory dir do
    recursive true
    mode "0755"
  end
end

directory "/var/log/fac-#{app}" do
  recursive true
  mode "0755"
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

template "#{script_dir}/fac-incremental-runner.sh" do
  source "fac-incremental-runner.sh.erb"
  owner "nobody"
  group "nobody"
  mode "0755"
  variables({
              :script_dir => script_dir,
              :radiobuild_dir => "#{node[:fac][:script_path]}/radiobuild",
              :radiobuild2_dir => "#{node[:fac][:script_path]}/radiobuild2"
            })
end

master = search(:node, "recipe:attivio\\:\\:clustermaster AND chef_environment:prod")
puts "DEBUG: MASTER: " + master[0].inspect
template "#{script_dir}/shipFAC2attivio.sh" do
  source "shipFAC2attivio.sh.erb"
  owner node[:attivio][:user]
  group node[:attivio][:group]
  mode "0755"
  variables({
              :attivio_master => master[0],
              :attivio_inputdir => "#{node[:attivio][:input_path]}"
            })
end

# GP 9/24/13 - updated. replaced cronwrap command with nsca_relay
cron_d "fac-music" do
 minute "2"
 hour "0"
<<<<<<< HEAD
 #weekday "2" # tuesday
 command "/usr/bin/cronwrap #{node[:hostname]} fac-music \"#{script_dir}/fac-incremental-runner.sh\""
=======
 # weekday "2" # tuesday
 command "/usr/bin/nsca_relay -S fac-music -- #{script_dir}/fac-incremental-runner.sh"
>>>>>>> master
 user "root"
end
