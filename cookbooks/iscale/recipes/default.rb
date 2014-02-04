#
# Cookbook Name:: iscale
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

template '/etc/init.d/iscale' do
  source 'iscale.sh.erb'
  owner "#{node[:iscale][:user]}"
  group "#{node[:iscale][:group]}"
  mode "755"
  variables ({
    :user         => "#{node[:iscale][:user]}",
    :app_home     => "#{node[:iscale][:app_home]}",
    :lock_file    => "#{node[:iscale][:lock_file]}"
  })
end

template '/etc/sysconfig/varnish' do
  source 'sysconfig_varnish.erb'
  owner "#{node[:iscale][:user]}"
  group "#{node[:iscale][:group]}"
  mode "644"
  # variables({})
end 

template '/etc/varnish/default.vcl' do
  source 'default.vcl.erb'
  owner "#{node[:iscale][:user]}"
  group "#{node[:iscale][:group]}"
  mode "644"
  # variables({})
end 

template "#{node[:iscale][:install_path]}/settings.json" do
  source 'settings.json.erb'
  owner "#{node[:iscale][:user]}"
  group "#{node[:iscale][:group]}"
  mode "644"
  variables ({
    :settings   => node[:iscale][:app_settings]
  })
end 

service 'iscale' do
  supports :start => true, :stop => true, :restart => true
  action [ :enable ]
end

 # unless tagged?("#{node[:iscale][:deploy_tag]}") && node.chef_environment == "prod"

  application "iscale" do
    path "#{node[:iscale][:install_path]}"
    owner "#{node[:iscale][:user]}"
    group "#{node[:iscale][:group]}"
    repository "#{node[:iscale][:git_repository]}"
    revision "#{node[:iscale][:git_branch]}"
    enable_submodules 'true'

    restart_command '/etc/init.d/iscale restart'

    # nodejs do
    #   entry_point "#{node[:iscale][:app_homedir]}/server.js"
    # end 

    notifies :restart, "service[iscale]", :immediately
  end

  
  # tag("#{node[:iscale][:deploy_tag]}") if node.chef_environment == "prod"

# end