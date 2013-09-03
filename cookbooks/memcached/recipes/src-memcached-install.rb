# install libmemcached from source 
# @TODO: change to rpm install 

directory "/root/build" do
  owner "root"
  group "root"
  action :create
end

remote_file "/root/build/libmemcached-0.51.tar.gz" do
  source "https://launchpad.net/libmemcached/1.0/0.51/+download/libmemcached-0.51.tar.gz"
  notifies :run, "bash[install_libmemcached]", :immediately
end

bash "install_libmemcached" do
  user "root"
  cwd "/root/build"
  code <<-EOH
    tar -zxf libmemcached-0.51.tar.gz
    (cd libmemcached-0.51/ && ./configure && make && make install)
  EOH
  action :nothing
end
