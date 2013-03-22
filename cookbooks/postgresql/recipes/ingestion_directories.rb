directory "/data" do
  owner "postgres"
  group "postgres"
  mode 0755
  action :create
end


directory "/data/sql-reports" do
  owner "postgres"
  group "postgres"
  mode 0700
  action :create
end

directory "/data/sql-reports/iad-ing101" do
  owner "postgres"
  group "postgres"
  mode 0700
  action :create
end

directory "/data/sql-reports/tmp" do
  owner "postgres"
  group "postgres"
  mode 0700
  action :create
end

directory "/data/sql-reports/tmp/iad-ing101" do
  owner "postgres"
  group "postgres"
  mode 0700
  action :create
end

directory "/data/backups" do
  owner "postgres"
  group "postgres"
  mode 0700
  action :create
end

directory "/data/backups/iad-ing101" do
  owner "postgres"
  group "postgres"
  mode 0700
  action :create
end
