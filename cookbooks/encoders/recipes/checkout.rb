#
# Cookbook Name:: encoder
# Recipe:: default
#
# Copyright 2013, iheartradio / clear channel
#
# All rights reserved - Do Not Redistribute
#

begin 
  unless tagged?("encoder-code-deployed")

# Fri Jul 26 13:33:38 UTC 2013
# Tempoarily removing deploy code until leonard fixes the config files for addins.  
# currently it breaks when it deploys because the code is hard coded to a bad config file

    application "converter" do
        path "#{node[:encoders][:deploy_path]}"
        deploy_key "encoder_deploy"
        repository node[:encoders][:github_url]
        revision "master"
    end

    deploy "converter" do
        repo node[:encoders][:github_url]
        symlink_before_migrate.clear
        create_dirs_before_symlink.clear
        purge_before_symlink.clear
        shallow_clone false
        symlinks.clear
        user "converter"
        deploy_to "#{node[:encoders][:deploy_path]}"
        action :deploy
        ssh_wrapper "/home/converter/encoder-wrap-ssh.sh"
    end

    tag("encoder-code-deployed")
    end
rescue
    untag("encoder-code-deployed")
end

