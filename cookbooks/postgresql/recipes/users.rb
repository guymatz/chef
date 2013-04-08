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
