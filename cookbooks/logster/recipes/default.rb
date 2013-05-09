include_recipe "git"

package "logcheck"

execute "git checkout logster" do
    command "git clone https://github.com/etsy/logster.git"
    creates "/var/tmp/logster"
    cwd "/var/tmp"
    action :run
    not_if { node.normal.attribute?("logster_deployed") }
end

directory "/usr/share/logster" do
    owner "root"
    group "root"
    mode "0755"
end

directory "/var/log/logster" do
    owner "root"
    group "root"
    mode "0755"
end

#execute "create logster" do
#    command "/usr/bin/install -m 0755 -t /usr/sbin /var/tmp/logster/logster"
#    creates "/usr/sbin/logster"
#end
#
#execute "create logster_helper" do
#    command "/usr/bin/install -m 0644 -t /usr/share/logster /var/tmp/logster/logster_helper.py"
#    creates "/usr/share/logster/logster_helper.py"
#end

# remove shitty logcheck cron that is broken on centos
if File.exists?("/etc/cron.d/logcheck") then
    bash "delete" do
    code <<-EOF
        rm -f /etc/cron.d/logcheck
    EOF
    end
end


bash "install" do
    code <<-EOF
        cd /var/tmp/logster;
        python setup.py install
    EOF
end

node[:logster][:static_files].each do |dest,src|
cookbook_file "#{dest}" do
    source "#{src}"
    mode 0555
#    not_if { node.normal.attribute?("logster_deployed") }
    end
end

ruby_block "deployed_flag" do
    block do
      node.set['logster_deployed'] = true
      node.save
    end
end

