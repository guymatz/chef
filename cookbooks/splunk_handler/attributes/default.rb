# Default Attributes for the Chef Exception & Reporting Handler for Splunk Cookbook.
#
# Attributes:: default
# Cookbook Name:: splunk_handler
# Source:: https://github.com/ampledata/cookbook-splunk_handler
# Author:: Greg Albrecht <mailto:gba@splunk.com>
# Copyright:: Copyright 2012 Splunk, Inc.
# License:: Apache License 2.0
#


default['chef_client']['handler']['splunk']['username'] = nil
default['chef_client']['handler']['splunk']['password'] = nil
default['chef_client']['handler']['splunk']['host'] = nil
default['chef_client']['handler']['splunk']['port'] = '8089'
default['chef_client']['handler']['splunk']['index'] = 'main'
default['chef_client']['handler']['splunk']['scheme'] = 'https'
