
directory node[:elasticsearch][:base_path] do
  recursive true
end

pkg = "elasticsearch-#{node[:elasticsearch][:version]}"

remote_file "#{Chef::Config[:file_cache_path]}/#{pkg}.tar.gz" do
  source "#{node[:elasticsearch][:url]}/#{pkg}.tar.gz"
  checksum "168864fed1a7"
end

execute "Untar elasticsearch" do
  command "tar zxf #{pkg}.tar.gz -C #{node[:elasticsearch][:base_path]}"
  cwd Chef::Config[:file_cache_path]
  creates "#{node[:elasticsearch][:base]}/#{pkg}"
end

link node[:elasticsearch][:deploy_path] do
  to "#{node[:elasticsearch][:base_path]}/#{pkg}"
end
