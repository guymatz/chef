include_recipe "postgresql::server"
include_recipe "postgresql::slony"

cookbook_file "/var/lib/pgsql/9.1/data/pg_hba.conf" do
  source "pg_hba.conf"
  mode 0600
  owner "postgres"
  group "postgres"
end

cookbook_file "/var/lib/pgsql/9.1/data/postgresql.conf" do
  source "postgresql.conf"
  mode 0600
  owner "postgres"
  group "postgres"
end
