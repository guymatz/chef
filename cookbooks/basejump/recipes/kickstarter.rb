
directory "#{node[:basejump][:kickstarter][:tftp_root]}/pxelinux.cfg" do
  owner "nobody"
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

node[:basejump][:kickstarter][:syslinux_links].each do |k,v|
  Chef::Log.info("target=" + k)
  Chef::Log.info("source=" + v)
   link tftp_root + "/" + k do
    to tftp_root + "/" + v
  end
end

cookbook_file "#{node[:basejump][:kickstarter][:tftp_root]}/menu.msg" do
  source "menu.msg"
  owner "nobody"
  group "nogroup"
  mode "0755"
end

directory "#{node[:basejump][:kickstarter][:tftp_root]}/modules" do
  owner "nobody"
  group "nogroup"
end

directory "#{node[:basejump][:kickstarter][:tftp_root]}/distros" do
  owner "nobody"
  group "nogroup"
end

%w{ chain.c32 mboot.c32 memdisk menu.c32 menu.msg vesamenu.c32 }.each do |f|
  cookbook_file "#{node[:basejump][:kickstarter][:tftp_root]}/modules/#{f}" do
    source f
    owner "nobody"
    group "nogroup"
    mode "0755"
  end
end

cookbook_file "#{node[:basejump][:kickstarter][:tftp_root]}/pxelinux.0" do
  source "pxelinux.0"
  owner "nobody"
  group "nogroup"
  mode "0755"
end

mirrors = node[:basejump][:kickstarter][:mirrors]
node[:basejump][:kickstarter][:flavors].each do |flavor,v|
  v.each do |release|
    directory "#{node[:basejump][:kickstarter][:tftp_root]}/distros/#{flavor}/#{release}/x86_64" do
      owner "root"
      group "root"
      recursive true
    end
    remote_file "#{node[:basejump][:kickstarter][:tftp_root]}/distros/#{flavor}/#{release}/x86_64/initrd.img" do
      source mirrors[flavor] + "/#{flavor}/#{release}/os/x86_64/images/pxeboot/initrd.img"
      action :create_if_missing
      owner "root"
      group "root"
      mode "0755"
    end
    remote_file "#{node[:basejump][:kickstarter][:tftp_root]}/distros/#{flavor}/#{release}/x86_64/vmlinuz" do
      source mirrors[flavor] + "/#{flavor}/#{release}/os/x86_64/images/pxeboot/vmlinuz"
      action :create_if_missing
      owner "root"
      group "root"
      mode "0755"
    end
  end
end

cookbook_file "#{node[:basejump][:kickstarter][:tftp_root]}/pxelinux.cfg/default" do
  source "default"
  owner "root"
  group "root"
  mode "0755"
end

cookbook_file "#{node[:basejump][:kickstarter][:tftp_root]}/pxelinux.cfg/background.png" do
  source "default"
  owner "root"
  group "root"
  mode "0755"
end

directory "#{node[:basejump][:install_path]}/current/kickstarter/repos" do
  owner "root"
  group "root"
  mode "0755"
end

template "#{node[:basejump][:install_path]}/current/kickstarter/repos/CentOS-Base.repo" do
  source "CentOS-Base.repo.erb"
  owner "root"
  group "root"
  mode "0755"
end
