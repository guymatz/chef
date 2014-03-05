# require 'pry'

node['mysql']['server']['packages'].each do |package_name|
  Chef::Log.info "Installing #{package_name}-#{node['mysql']['version']}"

  yum_package package_name do
    action :install
    version "#{node['mysql']['version']}"
  end
end

#----
node['mysql']['server']['directories'].each do |key, value|
  directory value do
    owner     'mysql'
    group     'mysql'
    mode      '0755'
    action    :create
    recursive true
  end
end

directory node['mysql']['data_dir'] do
  owner     'mysql'
  group     'mysql'
  action    :create
  recursive true
end

#----
template 'my.cnf' do
  path '/etc/my.cnf'
  source 'my.cnf.erb'
  owner 'root'
  group 'root'
  mode '0644'
  #notifies :start, 'service[mysql-start]', :immediately
end

if 1 > 2 #DO not start any services. Keep the code to simplify future upgrades
  # hax
  service 'mysql-start' do
    service_name node['mysql']['server']['service_name']
    action :nothing
  end
end

if 1 > 2 #If needed this command should be run manually
  execute "/usr/bin/mysql_install_db --datadir=#{node['mysql']['data_dir']} --user=mysql" do
    action :run
    creates "#{node['mysql']['data_dir']}/auto.cnf"
    #only_if { node['platform_version'].to_i < 6 }
  end
end

cmd = assign_root_password_cmd
Chef::Log.info "Running: #{cmd}"

execute 'assign-root-password' do
  command cmd
  action :run
  only_if "/usr/bin/mysql -u root -e 'show databases;'"
end

results = search(:users, "groups:dba OR groups:sysadmin")
alldbas = Array.new
results.each do |r|
  alldbas << r['id']
end

template '/etc/mysql_grants.sql' do
  source 'grants.sql.erb'
  owner  'root'
  group  'root'
  mode   '0600'
  action :create
  notifies :run, 'execute[install-grants]', :immediately
  variables(
            :dbas => alldbas
           )
end

cmd = install_grants_cmd
execute 'install-grants' do
  command cmd
  #notifies :restart, 'service[mysql]', :immediately
  only_if  "/usr/bin/mysql -u root -e 'show databases -p#{node['mysql']['server_root_password']};"
end

if 1 > 2
#----
  template 'final-my.cnf' do
    path '/etc/my.cnf'
    source 'my.cnf.erb'
    owner 'root'
    group 'root'
    mode '0644'
    notifies :reload, 'service[mysql]', :immediately
  end
end

service 'mysql' do
  service_name node['mysql']['server']['service_name']
  supports     :status => true, :restart => true, :reload => true
  action       [:enable]
end
