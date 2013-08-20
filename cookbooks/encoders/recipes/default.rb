#
# Cookbook Name:: encoder
# Recipe:: default
#
# Copyright 2013, iheartradio / clear channel
#
# All rights reserved - Do Not Redistribute
#

%w{ users::converter }.each do |r|
  include_recipe r
end

begin 
  unless tagged?("encoder-deployed")

    node[:pkgs686].each do |pkg|
      yum_package pkg do
        arch "i686"
      end
    end

    node[:pkgsx64].each do |pkg|
      yum_package pkg do
        arch "x86_64"
      end
    end

    node[:iheart_pkg].each do |ihr_pkg|
      package ihr_pkg do
        action :install
      end
    end

    node[:gems].each do |gem,ver|
      gem_package gem do
        action :install
        options "--no-ri --no-rdoc"
        version ver
      end
    end

    node[:jruby_gems].each do |gem,ver|
      bash "install_jruby" do
         code <<-EOF
             jruby -S gem install #{gem} -v #{ver} 
         EOF
      end
    end

    node[:encoders][:static_files].each do |dest,src|
      cookbook_file dest do
        source src
        mode 0555
        end
    end

    # directory where all the pid files are usually kept
    directory "/var/run/manager" do
        owner 'converter'
        group 'converter'
        action :create
        not_if do FileTest.directory?("/var/run/manager") end
    end

    cookbook_file "/home/converter/encoder-wrap-ssh.sh" do
        source node[:encoders][:wrapper_script]
        mode 0755
        action :create_if_missing
    end

# Fri Jul 26 13:33:38 UTC 2013
# Tempoarily removing deploy code until leonard fixes the config files for addins.  
# currently it breaks when it deploys because the code is hard coded to a bad config file

#    application "converter" do
#        path "#{node[:encoders][:deploy_path]}"
#        deploy_key "encoder_deploy"
#        repository node[:encoders][:github_url]
#        revision "master"
#    end
#
#    deploy "converter" do
#        repo node[:encoders][:github_url]
#        symlink_before_migrate.clear
#        create_dirs_before_symlink.clear
#        purge_before_symlink.clear
#        symlinks.clear
#        user "converter"
#        deploy_to "#{node[:encoders][:deploy_path]}"
#        action :deploy
#        ssh_wrapper "/home/converter/encoder-wrap-ssh.sh"
#    end

    # doing this as a bash block, because apparently you can't link directories 
    # natively https://tickets.opscode.com/browse/CHEF-2383
    bash "link_jdk" do 
        code <<-EOF
            ln -s /usr/java/jdk1.6.0_26/ /usr/bin/jdk
        EOF
        not_if { ::File.exists?("/usr/java/jdk1.6.0_26") } 
    end

    bash 'extract_sox' do
    code <<-EOH
        cd /tmp
        wget http://files.ihrdev.com/sox.tar.gz
        cd /
        tar xvzf /tmp/sox.tar.gz
        rm /tmp/sox.tar.gz
    EOH
    end

    tag("encoder-deployed")
    end
rescue
    untag("encoder-deployed")
end

