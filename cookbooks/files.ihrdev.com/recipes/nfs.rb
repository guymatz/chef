
unless node.run_list.include?("recipe[files.ihrdev.com::nfs]")
  node.run_list << 'recipe[files.ihrdev.com::nfs]'
end

include_recipe "users::deployer"

#hosts = search(:node, "recipes:files.ihrdev.com AND chef_environment:#{node.chef_environment}")
#ips = Array.new
#hosts.each do |h|
directory "#{node[:sto][:base_path]}/files.ihrdev.com" do
  mode "0775"
  action :create
end

nfs_export "#{node[:sto][:base_path]}/files.ihrdev.com" do
  network "10.5.32.0/23"
  writeable true
  sync true
  options ["no_root_squash"]
end

nfs_export "#{node[:sto][:base_path]}/files.ihrdev.com" do
  network "10.5.40.0/23"
  writeable true
  sync true
  options ["no_root_squash"]
end

nfs_export "#{node[:sto][:base_path]}/files.ihrdev.com" do
  network "10.5.42.128/25"
  writeable true
  sync true
  options ["no_root_squash"]
end

nfs_export "#{node[:sto][:base_path]}/files.ihrdev.com" do
  network "10.5.43.0/25"
  writeable true
  sync true
  options ["no_root_squash"]
end
