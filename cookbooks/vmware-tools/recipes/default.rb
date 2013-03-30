#
# Cookbook Name:: vmware-tools
# Recipe:: default
#

if node['virtualization']['system'] == 'vmware'

  node[:vmwaretools][:packages].each do |p|
    package p
  end

end
