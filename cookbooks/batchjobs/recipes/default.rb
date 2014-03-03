#
# Cookbook Name:: batchjobs
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

node[:batchjobs][:packages].each do |batchjob_pkg|
  package batchjob_pkg
end

node[:batchjobs][:pip_packages].each do |pip_batchjob_pkg, pip_batchjob_ver|
  python_pip pip_batchjob_pkg do
    version pip_batchjob_ver unless pip_batchjob_ver.nil?
    action :install
  end
end

directory "/var/log/celery/rovi/image/" do
  owner "batchjobs"
  group "batchjobs"
  mode  "0755"
  recursive true
end

template "/etc/odbcinst.ini" do
  source "odbcinst.ini.erb"
  mode "0644"
end

template "/etc/freetds.conf" do
  source "freetds.conf.erb"
  mode "0644"
end

template "/data/apps/batchjobs/jobs/rovi/bin/celeryconfig.py" do
  source "celeryconfig.py.erb"
  mode "0755"
  owner "batchjobs"
  group "batchjobs"
end

cron_d "Rovi_image_job" do
  command "/data/apps/batchjobs/jobs/rovi/bin/run_image_job.sh #{node[:batchjobs][:rovi_upload_identity]} > /dev/null 2>&1"
  minute "0"
  hour "21"
  user "batchjobs"
end

begin
  puts "entered deploy block"
  if not tagged?("batchjobs-deployed")
    directory "#{node[:batchjobs][:deploy_path]}" do
      owner "ihr-deployer"
      group "ihr-deployer"
      mode  "0755"
      recursive true
    end

    git "#{node[:batchjobs][:deploy_path]}" do
      repository node[:batchjobs][:repo]
      revision node[:batchjobs][:rev]
      action :sync
      notifies :run, 'bash[batchjob_perms]', :delayed
    end

    bash "batchjob_perms" do
      code "chown -R #{node[:batchjobs][:user]}.#{node[:batchjobs][:group]} #{node[:batchjobs][:deploy_path]};"
    end

    directory "/home/batchjobs/.ssh" do
      owner "batchjobs"
      group "batchjobs"
      mode  "0700"
      action :create
    end

    batchjobs_databag = Chef::EncryptedDataBagItem.load("secrets", "batchjobs")
    batchjobs_rsa_key = batchjobs_databag["batchjobs_rsa_private"]
    file "/home/batchjobs/.ssh/qaiheart_rsa" do
      owner "batchjobs"
      group "batchjobs"
      mode  "0600"
      content batchjobs_rsa_key
      action :create_if_missing
    end
    unless /development/ =~ node.chef_environment
      tag("batchjobs-deployed")
    end
  end
rescue
  untag("batchjobs-deployed")
end
