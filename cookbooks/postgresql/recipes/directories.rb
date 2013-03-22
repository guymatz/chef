directory "/data/dbdata" do
  owner "postgres"
  group "postgres"
  mode 0700
  action :create
end

directory "/data/wal" do
  owner "postgres"
  group "postgres"
  mode 0755
  action :create
end

directory "/data/index" do
  owner "postgres"
  group "postgres"
  mode 0755
  action :create
end

directory "/data/backups" do
  owner "postgres"
  group "postgres"
  mode 0755
  action :create
end

directory "/data/archwal" do
  owner "postgres"
  group "postgres"
  mode 0755
  action :create
end

directory "/home/postgres" do
  owner "postgres"
  group "postgres"
  mode  0775
  action :create
end

directory "/u03" do
  owner "postgres"
  group "postgres"
  mode  0775
  action :create
end

directory "/u03/pg" do
  owner "postgres"
  group "postgres"
  mode  0775
  action :create
end
