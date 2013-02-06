

case node['platform']
when "centos"
  default[:hive][:packages] = %w{ hive hive-metastore hive-server hive-server2 }
when "debian"
  default[:hive][:packages] = %w{ libmysql-java }
end
# http://www.mysql.com/get/Downloads/Connector-J/mysql-connector-java-5.1.22.tar.gz/from/http://mysql.he.net/
default[:hive][:version] = "5.1.22"
default[:hive][:url_pre] = "http://cdn.mysql.com/Downloads/Connector-J/mysql-connector-java-"


default[:hive][:mysql_migration_script] = "hive-schema-0.9.0.mysql.sql"

# MySQL stuff

default[:hive][:app_name] = "hive"
default[:hive][:db_user] = "hive"
default[:hive][:db_name] = "metastore"
