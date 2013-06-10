#
# Cookbook Name:: encoder
# Recipe:: default
#
# Copyright 2013, iheartradio / clear channel
#
# All rights reserved - Do Not Redistribute
#

node[:encoders][:filemonitor][:ingestion_links].each do |target,src|
    link "#{target}" do
        to "#{src}"
    end
end
