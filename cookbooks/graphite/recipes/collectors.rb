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
