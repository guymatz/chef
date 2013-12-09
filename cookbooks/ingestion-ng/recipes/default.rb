#
# Cookbook Name:: ingestion-ng
# Recipe:: default
#
# Copyright 2013, iheartradio / clear channel
#
# All rights reserved - Do Not Redistribute
#

%w{java users::converter users::deployer}.each do |r|
  include_recipe r
end

ingestion_root = "#{node[:ingestion_ng][:deploy_path]}/current/#{node[:ingestion_ng][:apps]}"
celery_config = "celery"
supervisor_log = "#{node[:ingestion_ng][:deploy_path]}/current/#{node[:ingestion_ng][:apps]}/var/log/"
supervisor_config = "#{node[:ingestion_ng][:deploy_path]}/current/#{node[:ingestion_ng][:apps]}/etc/supervisord.conf"
supervisor_pid = "#{node[:ingestion_ng][:deploy_path]}/current/#{node[:ingestion_ng][:apps]}/run/supervisor.pid"
venv_activate = "#{node[:ingestion_ng][:deploy_path]}/#{node[:ingestion_ng][:venv]}/bin/activate"
config_path = "#{node[:ingestion_ng][:deploy_path]}/current/#{node[:ingestion_ng][:apps]}/etc"
rabbit_data = Chef::EncryptedDataBagItem.load("rabbitmq", "passwords").to_hash

# python
node[:ingestion_ng][:packages].each do |p|
  package p
end

# top dir
directory node[:ingestion_ng][:deploy_path] do
  owner node[:ingestion_ng][:user]
  group node[:ingestion_ng][:group]
  mode "0775"
  recursive true
end


begin
  unless tagged? :ingestion_deployed

    # var dir
    directory node[:ingestion_ng][:var] do
      owner node[:ingestion_ng][:user]
      group node[:ingestion_ng][:group]
    end

    # venv
    python_virtualenv "#{node[:ingestion_ng][:deploy_path]}/#{node[:ingestion_ng][:venv]}" do
      interpreter "/usr/bin/python27"
      owner node[:ingestion_ng][:user]
      group node[:ingestion_ng][:group]
      options "--no-site-packages --distribute"
      action :create
    end

    # deploy
    deploy_branch node[:ingestion_ng][:deploy_path] do
      repo node[:ingestion_ng][:repo]
      branch node[:ingestion_ng][:branch]
      user node[:ingestion_ng][:user]
      group node[:ingestion_ng][:group]
      migrate false
      enable_submodules true
      action :deploy
      symlink_before_migrate.clear
      create_dirs_before_symlink.clear
      purge_before_symlink.clear
      symlinks.clear
      before_restart do
        bash "install project and reqs" do
          user node[:ingestion_ng][:user]
          group node[:ingestion_ng][:group]
          cwd node[:ingestion_ng][:deploy_path]
          code <<-EOH
          source #{node[:ingestion_ng][:venv]}/bin/activate
          pip install current/ingqueue/lib/jpype
          pip install -e current/ingqueue/src
          mkdir -p current/#{node[:ingestion_ng][:apps]}/var/{log,run}
          EOH
        end
        execute "stop-supervisor" do
          user node[:ingestion_ng][:user]
          group node[:ingestion_ng][:group]
          cwd "#{node[:ingestion_ng][:deploy_path]}/current/#{node[:ingestion_ng][:apps]}"
          command ". #{venv_activate} && supervisorctl stop all && supervisorctl shutdown && sleep 2"
          only_if "pgrep -f supervisord"
        end
        template "#{config_path}/celery.yml" do
          owner node[:ingestion_ng][:user]
          group node[:ingestion_ng][:group]
          mode "0644"
          variables({
            :celery => node[:ingestion_ng][:celery],
            :broker_url => node[:ingestion_ng][:celery][:broker_url] % {
                :user  => node[:ingestion_ng][:rabbit][:user],
                :pass  => rabbit_data[node[:ingestion_ng][:rabbit][:user]],
                :vhost => node[:ingestion_ng][:rabbit][:vhost]
            }
          })
        end
        template "#{config_path}/db.yml" do
          owner node[:ingestion_ng][:user]
          group node[:ingestion_ng][:group]
          mode "0644"
        end
      end
      after_restart do
        execute "restart-supervisor" do
          user node[:ingestion_ng][:user]
          group node[:ingestion_ng][:group]
          cwd "#{node[:ingestion_ng][:deploy_path]}/current/#{node[:ingestion_ng][:apps]}"
          command <<-EOH
          . #{venv_activate}
          pgrep -f supervisord || export SUPERVISOR_PIDFILE=#{supervisor_pid} && export INGESTION_PROJECT_ROOT=#{ingestion_root} && \
          export CELERY_CONFIG=#{celery_config} && supervisord -c #{supervisor_config} && supervisorctl start all
          EOH
        end
        execute "setup-web-db" do
          user node[:ingestion_ng][:user]
          group node[:ingestion_ng][:group]
          cwd "#{node[:ingestion_ng][:deploy_path]}/current/#{node[:ingestion_ng][:apps]}"
          command <<-EOH
          . #{venv_activate}
          export INGESTION_PROJECT_ROOT=#{ingestion_root} && export CELERY_CONFIG=#{celery_config}
          [ -s #{node[:ingestion_ng][:var]}/web.db ] || init_web_db
          EOH
          not_if { ::File.exists?("#{node[:ingestion_ng][:var]}/test.db") }
        end
      end
    end
  tag :ingestion_deployed
  end
rescue
  untag :ingestion_deployed
end
