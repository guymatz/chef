#
# Author:: Jake Plimack <jake.plimack@gmail.com>
# Cookbook Name:: nagios
# Recipe:: nsca_source
#
include_recipe "build-essential"

node[:nsca][:packages].each do |p|
  package p
end

nsca_version = node['nagios']['nsca']['version']

remote_file "#{Chef::Config[:file_cache_path]}/nsca-#{nsca_version}.tar.gz" do
  source "#{node['nagios']['nsca']['url']}/nsca-#{nsca_version}/nsca-#{nsca_version}.tar.gz"
  checksum node['nagios']['nsca']['checksum']
  action :create_if_missing
end

bash "compile-nsca" do
  cwd Chef::Config[:file_cache_path]
  code <<-EOH
    tar zxvf nsca-#{nsca_version}.tar.gz
    cd nsca-#{nsca_version}
    ./configure --prefix=/usr \
                --sysconfdir=/etc \
                --localstatedir=/var \
                --libexecdir=#{node['nagios']['plugin_dir']}
    make all
    cp src/send_nsca #{node['nagios']['plugin_dir']}
  EOH
  not_if "test -f #{node['nagios']['plugin_dir']}/send_nsca"
end

# setup send_nsca everywhere
# setup nsca as xinetd service on nagios-server

if node[:nagios][:nsca][:authkey].nil?
  res = search(:node, "recipes:nagios\\:\\:server")
  if res.nil?
    Chef::Log.info("No Nagios Servers Found: Bailing on NSCA config")
    return
  end
  nag_srv = res[0]

  if nag_srv[:nagios][:nsca][:authkey].nil?
    ::Chef::Recipe.send(:include, Opscode::OpenSSL::Password)
    Chef::Log.info("Creating NSCA key on Nagios server")
    nag_srv.set_unless[:nagios][:nsca][:authkey] = secure_password
    nag_srv.save
    authkey = nag_srv[:nagios][:nsca][:authkey]
    node.set[:nagios][:nsca][:authkey] = authkey
    node.save
  else
    Chef::Log.info("found NSCA key: " + nag_srv[:fqdn])
    Chef::Log.info("setting my key to " + nag_srv[:nagios][:nsca][:authkey])
    authkey = nag_srv[:nagios][:nsca][:authkey]
    node.set[:nagios][:nsca][:authkey] = authkey
    node.save
  end
else
  authkey = node[:nagios][:nsca][:authkey]
  Chef::Log.info("I have an NSCA key to use in my nodefile " + node[:fqdn])
end

template "/etc/nagios/send_nsca.conf" do
  source "send_nsca.cfg.erb"
  owner "root"
  group "root"
  mode "0600"
  variables ({
               :encryption => node[:nsca][:encryption],
               :authkey => authkey
             })
end

# this part is only for servers
if node[:recipes].include? 'nagios::server'

  bash "deploy-nsca-server-binary" do
  cwd Chef::Config[:file_cache_path]
  code <<-EOH
    cd nsca-#{nsca_version}/src
    cp nsca #{node['nsca']['server'][:path]}
  EOH
    not_if "test -f #{node['nsca']['server'][:path]}"
  end

  template node[:nsca][:server][:config] do
    source "nsca.cfg.erb"
    owner node[:nagios][:user]
    group node[:nagios][:group]
    mode "0600"
    variables ({
                 :encryption => node[:nsca][:encryption],
                 :authkey => authkey
               })
  end

  service "xinetd" do
    supports :status => true, :restart => true, :start => true, :stop => true
    action :nothing
  end

  template "/etc/xinetd.d/nsca" do
    source "nsca.xinetd.erb"
    owner "root"
    group "root"
    mode "0600"
    variables ({
                 :nsca => node[:nsca],
                 :nagios => node[:nagios]
               })
    notifies :restart, resources(:service => "xinetd"), :immediate
  end

end
