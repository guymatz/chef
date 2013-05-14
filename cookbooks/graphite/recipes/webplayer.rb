#
# Cookbook Name:: graphite
# Recipe:: webplayer
#
# Installs IHR custom web landing page for our graphite servers
#
# drop a github private deploy key for status-deploy


include_recipe "logster::default"

deploy_keys = Chef::EncryptedDataBagItem.load("keys", "monitoring-deploy")
directory "/root/.ssh" do
    recursive true
    mode "0700"
end


template "/etc/init.d/webstats" do
    mode "0755"
    source "webstats.erb"
        variables(
        )
end


file "/root/.ssh/monitoring-deploy" do
    mode "0400"
    content deploy_keys['private_key']
    :create_if_missing
end

#file "/root/.ssh/config" do
#    mode "0755"
#    content <<-EOH
#        Host *github.com *.ihr iad-search*
#        IdentityFile "/root/.ssh/monitoring-deploy"
#        StrictHostKeyChecking no
#    EOH
#    :create_if_missing
#end

package "nc" do
    action :install
end

easy_install_package "apscheduler" do
    action :install
end

git node[:graphite][:amp_install_path] do
    repository node[:graphite][:amprepo]
    revision "HEAD"
    action :sync
end

service "webstats" do
    action [ :enable, :start ]
    supports :start => true, :stop => true, :restart => true, :status => true
end
