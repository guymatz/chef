#
# Cookbook Name:: fac
# Recipe:: talk
#
# Copyright 2013, iHeartRadio
#
# All rights reserved - Do Not Redistribute
#

node.set[:java][:oracle][:accept_oracle_download_terms] = true
node.save
include_recipe "java"

download_url = "#{node[:fac][:url]}/FAC-talk/#{node[:fac][:prn][:version]}/FAC-talk-#{node[:fac][:prn][:version]}.jar"
script_dir = "#{node[:fac][:script_path]}/talk"

directory "#{script_dir}" do
  recursive true
end

remote_file "#{script_dir}/fac-talk.jar" do
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

template "/etc/init.d/fac-talk" do
  source "fac.init.erb"
  mode "0755"
  owner "root"
  group "root"
  variables({
              :fac_app => "talk",
              :jarfile => "#{script_dir}/fac-talk.jar"
            })
end
