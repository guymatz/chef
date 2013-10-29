#
# Cookbook Name:: graphite
# Recipe:: imagescaler
#
# Installs IHR custom imgscaler landing page for our graphite servers
#
# drop a github private deploy key for status-deploy


include_recipe "logster::default"

template "/etc/init.d/imgscaler" do
    mode "0755"
    source "imgscalestats.erb"
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

service "imgscaler" do
    action [ :enable, :start ]
    supports :start => true, :stop => true, :restart => true, :status => true
end
