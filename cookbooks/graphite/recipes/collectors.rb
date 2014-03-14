package "python-pyquery"

directory "/data/collectors" do
  action :create
  owner "root"
  group "root"
  mode 00644
end

cookbook_file "/data/collectors/carpathia.py" do
  source "carpathia-traffic.py"
  owner "root"
  group "root"
  mode 0755
end

cron "carpathia" do
  action :create
  user "root"
  command "/data/collectors/carpathia.py"
end

cookbook_file "/data/collectors/es2graphite.py" do
  source "es2graphite.py"
  owner "root"
  group "root"
  mode 0755
end

supervisor_service "es2graphite" do
  command "/data/collectors/es2graphite -p elastic -g iad-graphite101.ihr iad-search401-v200.ihr:9200"
  action [:enable, :restart]
  autostart true
  user "nobody"
  numprocs 1
end
