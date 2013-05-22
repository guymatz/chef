#
# Cookbook Name:: graphite
# Recipe:: raspberry
#
# Installs IHR custom web landing page for our graphite servers
#
# drop a github private deploy key for status-deploy
package "gnu-free-sans-fonts"

git node[:graphite][:web_install_path] do
    repository node[:graphite][:repo]
    revision "HEAD"
    action :sync
end

