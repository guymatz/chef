
directory node[:elasticsearchnew][:base_path] do
  owner node[:elasticsearchnew][:user]
  group node[:elasticsearchnew][:group]
  recursive true
end

pkg = "elasticsearch-#{node[:elasticsearchnew][:version]}"

remote_file "#{Chef::Config[:file_cache_path]}/#{pkg}.tar.gz" do
  source "#{node[:elasticsearchnew][:url]}/#{pkg}.tar.gz"
  owner node[:elasticsearchnew][:user]
  group node[:elasticsearchnew][:group]
end

execute "Untar elasticsearchnew" do
  command "tar zxf #{pkg}.tar.gz -C #{node[:elasticsearchnew][:base_path]}"
  cwd Chef::Config[:file_cache_path]
  user node[:elasticsearchnew][:user]
  group node[:elasticsearchnew][:group]
  not_if { ::File.exists?("#{node[:elasticsearchnew][:base_path]}/#{pkg}") }
end

link node[:elasticsearchnew][:deploy_path] do
  to "#{node[:elasticsearchnew][:base_path]}/#{pkg}"
end
