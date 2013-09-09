#
# Cookbook Name:: graphite
# Recipe:: amp
#
# Installs IHR custom web landing page for our graphite servers
#
# drop a github private deploy key for status-deploy


include_recipe "logster::default"


template "/etc/init.d/newstats" do
    mode "0755"
    source "newstats.erb"
        variables(
        )
end

package "nc" do
    action :install
end

easy_install_package "apscheduler" do
    action :install
end

easy_install_package "simplejson" do
    action :install
end

git node[:graphite][:amp_install_path] do
    repository node[:graphite][:amprepo]
    revision "HEAD"
    action :sync
end

service "newstats" do
    action [ :enable, :start ]
    supports :start => true, :stop => true, :restart => true, :status => true
end
