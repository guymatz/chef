


default[:hive][:packages] = %w{ hive hive-metastore hive-server hive-server2 }

# http://www.mysql.com/get/Downloads/Connector-J/mysql-connector-java-5.1.22.tar.gz/from/http://mysql.he.net/
default[:hive][:version] = "5.1.22"
default[:hive][:url_pre] = "http://cdn.mysql.com/Downloads/Connector-J/mysql-connector-java-"
