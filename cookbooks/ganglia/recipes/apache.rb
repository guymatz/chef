
if node.run_list.include("recipe[apache2]")

  status_port = node[:apache][:listen_ports].first

  template "#{node[:ganglia][:python_mods]}/apache_status.py" do
    source "python_modules/apache_status/python_modules/apache_status.py"
    owner node[:ganglia][:user]
    group node[:ganglia][:group]
    mode "0755"
  end

  template "#{node[:ganglia][:conf_d]}/apache_status.pyconf" do
    source "python_modules/apache_status/conf.d/apache_status.pyconf"
    owner node[:ganglia][:user]
    group node[:ganglia][:group]
    mode "0755"
  end

end
