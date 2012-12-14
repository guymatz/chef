#!/usr/bin/env ruby
# Installs, configures & starts splunkforwrader.
#
# Recipe:: default
# Cookbook Name:: splunkforwarder
# Source:: https://github.com/ampledata/cookbook-splunkforwarder
# Author:: Greg Albrecht <mailto:gba@splunk.com>
# Copyright:: Copyright 2012 Splunk, Inc.
# License:: Apache License 2.0
#


include_recipe 'splunkforwarder::package'
include_recipe 'splunkforwarder::service'
