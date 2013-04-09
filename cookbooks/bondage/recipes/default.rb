#
# Cookbook Name:: bondage
# Recipe:: default
#
# Copyright 2013, iHeartRadio
#
# All rights reserved - Do Not Redistribute
#

# The default recipe will determine whether we're already setup
# or if we need to do work, and will do as little as possible

node_addresses = {}
node[:network][:interfaces].each do |iface, vals|
  begin
    vals[:addresses].each do |addr, h|
      next unless h['family'] == 'inet' && !addr.match('127.0.0.1')
      iface_data = Hash.new
      iface_data = h.dup
      iface_data['address'] = addr
      node_addresses[iface] = iface_data
    end
  rescue
  end
end

begin
  Chef::Log.info("Creating modprobe-config: bonding")
  case node[:platform_family]
  when "rhel"
    # Persistant loading of bonding module
    # We will set options later when we define the interfaces
    file "/etc/sysconfig/modules/bonding.modules" do
      content "modprobe bonding"
      owner "root"
      group "root"
    end
end

include_recipe "bondage::bonds"
