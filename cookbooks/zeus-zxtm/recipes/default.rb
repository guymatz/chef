#
# Cookbook Name:: zeus-zxtm
# Recipe:: default
#

begin
    unless tagged?("zeus-deployed")

    remote_file "/tmp/zeus-tarball.tgz" do
      source node[:zeus][:tarball_url]
      checksum node[:zeus][:checksum]
      mode 0644
      action :create_if_missing
      not_if "test -f #{node[:zeus][:zeus_root]}/LICENSE"
    end

    # Get our encrypted data
    enc_data = Chef::EncryptedDataBagItem.load("zeus", "items")

    # Get the license from an encrypted data bag.
    license_key = "/tmp/zeus-license-#{$$}.txt"

    file license_key do
      owner "root"
      group "root"
      action :create
      host = node[:fqdn]
      content enc_data["license_index"][host]
      not_if "test -f #{node[:zeus][:zeus_root]}/LICENSE"
    end

    # make helper files
    template "/tmp/zinstall-script.txt" do
      source "zinstall-script.txt.erb"
      owner "root"
      mode 0700
      not_if "test -f #{node[:zeus][:zeus_root]}/LICENSE"
    end

    template "/tmp/configure-script.txt" do
      source "configure-script.txt.erb"
      owner "root"
      mode 0700
      variables(
        :password => enc_data["password"],
        :license_key => license_key
      )
      not_if "test -f #{node[:zeus][:zeus_root]}/LICENSE"
    end

    bash "install_zeus" do
      user "root"
      cwd "/tmp"
      code <<-EOH
        tar -zxf zeus-tarball.tgz
        cd #{node[:zeus][:tarball_dir]}
        ./zinstall --replay-from=/tmp/zinstall-script.txt
        #{node[:zeus][:zeus_root]}/zxtm/configure --replay-from=/tmp/configure-script.txt    
      EOH
      not_if "test -f #{node[:zeus][:zeus_root]}/LICENSE"
    end


    directory "/root/scripts" do
      owner "root"
      group "root"
      mode  0755
    end

    cookbook_file "failover_check.py" do
      path "/root/scripts/failover_check.py"
      owner "root"
      group "root"
      mode  0755
    end

    cookbook_file "vips" do
      path "/root/scripts/vips"
      owner "root"
      group "root"
      mode  0755
    end

    cron "failover_check.py" do
      command "/usr/bin/python /root/scripts/failover_check.py"
      minute  "*"
      hour    "*"
      day     "*"
      month   "*"
      weekday "*"
    end

    tag("zeus-deployed")
    end
rescue
    untag("zeus-deployed")
end
