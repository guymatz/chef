include_recipe "users::dba"

# dbas = search(:users, "groups:dba and groups:sysadmin")
# dbas.each do |u|
#   psql_user u["id"] do
#     host node["fqdn"]
#     port node['postgresql']['config']['port']
#     admin_username 'postgres'
#     admin_password node['postgresql']['password']['postgres']
#     password nil
#     host "localhost"
#   end
# end

group "postgres" do
  gid 26
end

directory "/home/postgres" do
  owner "postgres"
  group "postgres"
  mode 0700
  action :create
end

user "postgres" do
  shell "/bin/bash"
  comment "PostgreSQL Server"
  home "/home/postgres"
  gid "postgres"
  system true
  uid 26
  supports :manage_home => false
end

sudo "postgresql-dba" do
  group "dba"
  commands ["ALL"]
  runas "postgres"
  nopasswd true
end

sudo "postgresql-sysadmin" do
  group "dba"
  commands ["ALL"]
  runas "root"
  nopasswd true
end

sudo "postgres-user" do
  group "postgres"
  commands ["/etc/init.d/postgresql-9.1"]
  runas "root"
  nopasswd true
end
