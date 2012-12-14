# Installs & Initializes the Chef Exception & Reporting Handler for Splunk.
#
# Recipe:: default
# Cookbook Name:: splunk_handler
# Source:: https://github.com/ampledata/cookbook-splunk_handler
# Author:: Greg Albrecht <mailto:gba@splunk.com>
# Copyright:: Copyright 2012 Splunk, Inc.
# License:: Apache License 2.0
#


splunk_params = node['chef_client']['handler']['splunk']

if (splunk_params['username'] and splunk_params['password'] and
    splunk_params['host'])

  include_recipe 'chef_handler'

  chef_gem 'chef-handler-splunk' do
    version '2.1.0'
  end

  chef_handler 'Chef::Handler::SplunkHandler' do
    action :enable
    arguments [
      username=splunk_params['username'],
      password=splunk_params['password'],
      host=splunk_params['host'],
      port=splunk_params['port'],
      index=splunk_params['index'],
      scheme=splunk_params['scheme']
    ]
    source File.join(Gem.all_load_paths.grep(/chef-handler-splunk/).first,
                     'chef', 'handler', 'splunk.rb')
  end
end
