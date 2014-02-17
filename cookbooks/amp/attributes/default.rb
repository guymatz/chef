
default[:amp][:version] = "2.21-utopia"
default[:amp][:amp_rest_version] = "2.21.0"
default[:amp][:url] = "http://files.ihrdev.com/amp"

default[:amp][:packages] = %w{ mongo-10gen-server mongo-10gen }

default[:amp][:authdb][:host] = "iad-auth101-v260.ihr"
default[:amp][:pgbouncer][:port] = "5432"

default[:amp][:logging][:script_path] = "/data/apps/amp/logging"
default[:amp][:logging][:log_path] = "/var/log/amp"
default[:amp][:logger][:log_path] = "/data/apps/tomcat7/logs"

default[:amp][:logger][:url] = "http://files.ihrdev.com/amp/logger.war"

default[:amp][:logging][:user] = "nobody"
case node[:platform_family]
when "rhel"
  default[:amp][:logging][:group] = "nobody"
when "debian"
  default[:amp][:logging][:group] = "nogroup"
else
  default[:amp][:logging][:group] = "nobody"
end

# GP EDIT 8/16/13 Included a list of people to notify when endpoints show alert levels of 500s 
# Used in ./templates/default/amp-extended-log-chk.sh.erb
default[:amp][:logging][:notify_list] = %w{ jeremybraff@clearchannel.com kengilmer@clearchannel.com LaurentVauthrin@clearchannel.com mauricewalden@clearchannel.com }


# Trying to port over relevant attributes from stg
default[:amp][:usr_mongo][:hosts] = "localhost:27017"
default[:amp][:usr_mongo][:connections_per_host] = 300
default[:amp][:usr_mongo][:connect_timeout] = 3000
default[:amp][:usr_mongo][:socket_timeout] = 3000
default[:amp][:usr_mongo][:maxWaitTime] = 3000
default[:amp][:usr_mongo][:threads_allowed_to_block_for_connections_multiplier] = 5
default[:amp][:fac_mongo][:hosts] = "iad-mongo-fac101-v240.ihr:37017,iad-mongo-fac102-v240.ihr:37017,iad-mongo-fac103-v240.ihr:37017,iad-mongo-fac104-v240.ihr:37017"
default[:amp][:fac_mongo][:connections_per_host] = 300
default[:amp][:fac_mongo][:connect_timeout] = 5000
default[:amp][:fac_mongo][:socket_timeout] = 5000
default[:amp][:fac_mongo][:maxWaitTime] = 5000
default[:amp][:fac_mongo][:threads_allowed_to_block_for_connections_multiplier] = 5
default[:amp][:dwh][:radiomodel_jdbc_url] = "jdbc:jtds:sqlserver://iad-dwh-db102-vip.ihrint.com:1433;DatabaseName=RadioModel"
