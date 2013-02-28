
directory "#{node[:basejump][:kickstarter][:tftp_root]}/pxelinux.cfg" do
  owner "root"
  group "nogroup"
  mode "0755"
  action :create
  recursive true
end

case node['platform']
when "debian"
  template "/etc/xinetd.d/tftp" do
    source "tftp.xinetd"
    owner "root"
    group "root"
    mode "0644"
    variables({
               :tftp_root => node[:basejump][:kickstarter][:tftp_root]
              })
  end
end

service "xinetd" do
  action :restart
end

remote_file "#{node[:basejump][:kickstarter][:tftp_root]}/syslinux-5.01.tar.gz" do
  puts "Downloading SYSLINUX from #{node[:basejump][:kickstarter][:syslinux_url]}"
  source node[:basejump][:kickstarter][:syslinux_url]
  action :create_if_missing
end

bash "Extract SYSLINUX" do
  cwd node[:basejump][:kickstarter][:tftp_root]
  code <<-EOH
tar zxvf syslinux-5.01.tar.gz
EOH
  not_if "test -d #{node[:basejump][:kickstarter][:tftp_root]}/syslinux-5.01"
end

tftp_root = node[:basejump][:kickstarter][:tftp_root]
node[:basejump][:kickstarter][:syslinux_links].map{|t|
  Chef::Log.info("t=" + t.inspect)
  }
  # link tftp_root + "/" + t['target_file'] do
  #   to tftp_root + "/" + t['source_file']
  # end
