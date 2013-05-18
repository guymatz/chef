if platform?( "redhat", "centos", "fedora" )
  package "apr-devel"
  package "libconfuse-devel"
  package "expat-devel"
  package "rrdtool-devel"
end

node[:ganglia][:packages].each do |p|
  package p
end

git "/usr/src/ganglia-#{node[:ganglia][:version]}" do
  repo node[:ganglia][:repo]
  action :sync
end

src_path = "/usr/src/ganglia-#{node[:ganglia][:version]}"

execute "bootstrap ganglia build" do
  command "./bootstrap"
  creates "#{src_path}/config.log"
  cwd src_path
end

execute "configure ganglia build" do
  command "./configure --with-gmetad --with-libpcre=no --sysconfdir=/etc/ganglia"
  creates "#{src_path}/config.log"
  cwd src_path
end

execute "build ganglia" do
  command "make"
  creates "#{src_path}/gmond/gmond"
  cwd src_path
end

execute "install ganglia" do
  command "make install"
  creates "/usr/sbin/gmond"
  cwd src_path
end

link "/usr/lib/ganglia" do
  to "/usr/lib64/ganglia"
  only_if do
    node[:kernel][:machine] == "x86_64" and
      platform?( "redhat", "centos", "fedora" )
  end
end
