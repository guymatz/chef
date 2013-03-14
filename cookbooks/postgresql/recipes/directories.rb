directory "/data/dbdata" do
  owner "postgres"
  group "postgres"
  mode 0755
  action :create
end

directory "/data/wal" do
  owner "postgres"
  group "postgres"
  mode 0755
  action :create
end

directory "/data/dbindex" do
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
