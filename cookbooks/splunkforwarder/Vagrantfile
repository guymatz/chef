# Vagrantfile for splunkforwarder Cookbook.
#
# -*- mode: ruby -*-
# vi: set ft=ruby :
#
# Author:: Greg Albrecht <mailto:gba@splunk.com>
# Copyright:: Copyright 2012 Splunk, Inc.
# License:: Apache License 2.0
#


Vagrant::Config.run do |config|
  config.vm.box = 'stormbase_200'
  config.vm.box_url = 'https://dl.dropbox.com/u/4036736/stormbase_200.box'
  config.vm.host_name = 'splunkforwarder'
  config.vm.forward_port(8000, 6180)
  config.vm.forward_port(8089, 6189)
  config.vm.provision :chef_solo do |chef|
    chef.cookbooks_path = ENV['CB_TMP']
    chef.run_list = 'splunkforwarder'
  end
end
