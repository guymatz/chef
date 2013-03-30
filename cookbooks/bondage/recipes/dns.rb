#
# Cookbook Name:: bondage
# Recipe:: bonds
#
# Copyright 2013, iHeartRadio
#
# All rights reserved - Do Not Redistribute
#

include_recipe "bondage::default"

chef_gem "net-dns" do
  action :install
end

require 'socket'
require 'rubygems'
require 'net/dns'


node[:fqdn] =~ /(\w*-\w*\d*)(\..*)$/
shortname = $1
domain = $2

res = Net::DNS::Resolver.new
ihrzone = res.axfr 'ihr'

interfaces = Hash.new

# be careful, this thinks every IP is a /32 address, to_s will strip it
ihrzone.answer.each do |rr|
  if rr.type == 'A' and rr.name.include? shortname + "-v"
    rr.name =~ /(\w*-\w*\d*)-v(\d*)(\..*)$/
    interfaces[rr.name] = ({
                             :ip => rr.address.to_s,
                             :vlan => $2
                           })
  end
end

if interfaces.nil? or interfaces.count == 0
  Chef::Log.info("No tagged interfaces found in dns for " + shortname)
  return
end

puts "We're going to setup:\n" + interfaces.inspect
