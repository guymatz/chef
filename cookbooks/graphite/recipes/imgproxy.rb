#
# Cookbook Name:: graphite
# Recipe:: imgproxy
#
# Installs IHR custom imgproxy landing page for our graphite servers
#
# drop a github private deploy key for status-deploy


include_recipe "logster::default"

template "/etc/init.d/imgproxy" do
    mode "0755"
    source "imgproxystats.erb"
        variables(
        )
end

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

service "imgproxy" do
    action [ :enable, :start ]
    supports :start => true, :stop => true, :restart => true, :status => true
end
