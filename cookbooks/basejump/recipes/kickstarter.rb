
directory "#{node[:basejump][:kickstarter][:tftp_root]}/pxelinux.cfg" do
  owner "root"
  group "nogroup"
  mode "0755"
  action :create
  recursive true
end

case node['platform']
when "debian"
  template "/etc/default/tftpd-hpa" do
    source "tftpd-hpa.erb"
    owner "root"
    group "root"
    mode "0644"
    variables({
               :tftp_root => node[:basejump][:kickstarter][:tftp_root]
              })
  end
end
