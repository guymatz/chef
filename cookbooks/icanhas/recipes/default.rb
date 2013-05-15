#
# Cookbook Name:: icanhas
# Recipe:: default
#
# Copyright 2013, iHeartRadio
#
# All rights reserved - Do Not Redistribute
#


hazers = search(:icanhas, "*:*")

hazers.each do |dude|
  dude['repos'].each do |repo,repo_data|
    puts "checking out repo #{repo} for #{dude['id']}"
    puts "DEBUG: " + repo_data.inspect
    git "/home/#{dude['id']}/#{repo}" do
      repository repo_data['repo']
      action :sync
    end
    unless repo_data['setup'].nil? or repo_data['setup'].empty?
      puts "DEBUG CMD: " + repo_data['setup'].inspect
      bash "#{dude['id']} - #{repo} - setup" do
        user dude['id']
        cwd "/home/#{dude['id']}"
        code repo_data['setup']
      end
    end
  end
end
