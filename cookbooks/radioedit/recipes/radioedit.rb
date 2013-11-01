#
# Cookbook Name:: elasticsearchnew
# Recipe:: default
#
# Copyright 2013, iHeartRadio
#
# All rights reserved - Do Not Redistribute
#

unless tagged?('elasticsearchnew-deployed')
  %w{ users::elasticsearch 
      elasticsearchnew::users 
      users::deployer 
      elasticsearchnew::elasticsearch 
      elasticsearchnew::ulimits 
    }.each { |cb| include_recipe cb; }
  
  template "/etc/init.d/elasticsearch" do
    source "elasticsearch.init.erb"
    owner "root"
    group "root"
    mode "0755"
    notifies :restart, "service[elasticsearch]"
  end
  
  service "elasticsearch" do
    supports :start => true, :stop =>true, :restart => true
    action :enable
  end
  
  cluster_members = search(:node, "cluster_name:#{node[:elasticsearchnew][:cluster_name]}")
  
  cluster_ips = Array.new
  cluster_members.each do |s|
    #cluster_ips << s["network"]["interfaces"]["eth0"]["addresses"].to_hash.select {|addr, info| info["family"] == "inet"}.flatten.first
    cluster_ips << s[:ipaddress]
  end
  
  template "#{node[:elasticsearchnew][:ihrsearch_path]}/configs/elasticsearch.yml" do
    source "elasticsearch.yml.erb"
    owner node[:elasticsearchnew][:user]
    group node[:elasticsearchnew][:group]
    variables({
                :cluster_ips => cluster_ips.join(',')
               })
    notifies :restart, "service[elasticsearch]"
  end

  tag('elasticsearchnew-deployed')
end

