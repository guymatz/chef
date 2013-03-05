#
# Cookbook Name:: attivio
# Recipe:: default
#
# Copyright 2013, iHeartRadio
#
# All rights reserved - Do Not Redistribute
#

include_recipe "attivio::users"

node[:attivio][:packages].each do |p|
  package p
end

directory node[:attivio][:install_path] do
  owner node[:attivio][:user]
  group node[:attivio][:group]
  mode "0755"
  recursive true
end

git node[:attivio][:install_path] do
  repository node[:attivio][:repo]
  revision  node[:attivio][:rev]
  user node[:attivio][:user]
  group node[:attivio][:group]
  action :sync
end

cookbook_file "/tmp/AIE-installer.sh.gz" do
  source "AIE_lin64_3.1.3.56386.sh.gz"
  action :create_if_missing
  owner "root"
  group "root"
end

script "unpack attivio installer" do
  interpreter "bash"
  user "root"
  cwd "/tmp"
  code <<-EOH
/bin/gzip -d AIE-installer.sh.gz
EOH
  not_if "test -f /tmp/AIE-installer.sh"
end

template "/tmp/AIE-installer.exp" do
  source "attivio.exp.erb"
  owner "root"
  group "root"
  mode "0700"
  variables ({
               :aie_install_path => node[:attivio][:aie_install_path]
             })
end

directory node[:attivio][:aie_install_path] do
  owner node[:attivio][:user]
  group node[:attivio][:group]
  recursive true
end

script "run attivio installer via Expect" do
  interpreter "expect"
  cwd "/tmp"
  code <<-EOH
/usr/bin/expect /tmp/AIE-installer.exp
EOH
  not_if "test -d #{node[:attivio][:aie_install_path]}"
end
