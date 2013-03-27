

include_recipe "postgresql::server"
include_recipe "postgresql::slony"

node[:ingestion][:database][:packages].each do |p|
  package p
end


#cookbook_file "/var/lib/pgsql/9.1/data/pg_hba.conf" do
#  source "pg_hba.conf"
#  mode 0600
#  owner "postgres"
#  group "postgres"
#end

#cookbook_file "/var/lib/pgsql/9.1/data/postgresql.conf" do
#  source "postgresql.conf"
#  mode 0600
#  owner "postgres"
#  group "postgres"
#end

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
