# install libmemcached from source 
# @TODO: change to rpm install 

directory "/root/build" do
  owner "root"
  group "root"
  action :create
end

remote_file "/root/build/libmemcached-0.51.tar.gz" do
  source "http://yum.ihr/files/libmemcached-0.51.tar.gz"
  notifies :run, "bash[install_libmemcached]", :immediately
end

bash "install_libmemcached" do
  user "root"
  cwd "/root/build"
  code <<-EOH
    tar -zxvf libmemcached-0.51.tar.gz
    (cd libmemcached-0.51/ && ./configure && make -v && make -v install)
  EOH
  action :nothing
end
