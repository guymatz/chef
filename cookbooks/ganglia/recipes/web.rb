directory "/etc/ganglia-webfrontend"

case node[:platform]
when "ubuntu", "debian"
  package "ganglia-webfrontend"

  link "/etc/apache2/sites-enabled/ganglia" do
    to "/etc/ganglia-webfrontend/apache.conf"
    notifies :restart, "service[apache2]"
  end

when "redhat", "centos", "fedora"
  include_recipe "apache2"
  include_recipe "php"
  include_recipe "ganglia::source"
  include_recipe "ganglia::gmetad"

  directory node[:ganglia][:web_dir] do
    owner node[:apache][:user]
    group node[:apache][:group]
    recursive true
  end

  execute "copy web directory" do
    puts "executing: cp -r /usr/src/ganglia-#{node[:ganglia][:version]}/web #{node[:ganglia][:web_dir]}"
    command "cp -r /usr/src/ganglia-#{node[:ganglia][:version]}/web #{node[:ganglia][:web_dir]}"
    creates "#{node[:ganglia][:web_dir]}"
    cwd "/usr/src/ganglia-#{node[:ganglia][:version]}"
    not_if "test -f #{node[:ganglia][:web_dir]}/ganglia.php"
  end

  web_app "ganglia" do
    server_name "ganglia.ihrdev.com"
    server_aliases [node['fqdn'], "ganglia.ihrdev.com"]
    docroot node[:ganglia][:web_dir]
  end

end

service "apache2" do
  service_name "httpd" if platform?( "redhat", "centos", "fedora" )
  supports :status => true, :restart => true, :reload => true
  action [ :enable, :start ]
end
