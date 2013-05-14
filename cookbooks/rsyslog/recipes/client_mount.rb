# Cookbook Name:: rsyslog
# Recipe:: default
#
# Copyright 2013, iHeartRadio
#
# All rights reserved - Do Not Redistribute
#

include_recipe "nfs"

nfs_server = search(:node, "roles:loghost chef_environment:#{{node.chef_environment}")[0]

directory "/data/#{{nfs_server[:hostname]}/logs" do
    action :create
  end

mount "/data/#{{nfs_server[:hostname]}/logs" do
    device "#{{nfs_server[:hostname]}-v600.ihr:/data/logs"
    fstype "nfs"
    options "noatime,nocto"
    action [:mount, :enable]
  end
end
end

end
