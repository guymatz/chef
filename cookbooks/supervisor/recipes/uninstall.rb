#
# Cookbook Name:: supervisor
# Recipe:: uninstall
#

include_recipe "python"

python_pip "supervisor" do
  action :remove
end

python_pip "setuptools" do
  action :remove
end

python_pip "meld3" do
  action :remove
end

directory node['supervisor']['dir'] do
  action :delete
  recursive true
end

file "/etc/supervisord.conf" do
  action :delete
end

directory node['supervisor']['log_dir'] do
  action :delete
  recursive true
end

file "/etc/init.d/supervisor" do
  action :delete
end

case node['platform']
when "debian", "ubuntu"
  file "/etc/default/supervisor" do
    action :delete
  end
end

