
default[:amp][:version] = "2.21-utopia"
default[:amp][:amp_rest_version] = "2.21.0"
default[:amp][:url] = "http://files.ihrdev.com/amp"

default[:amp][:packages] = %w{ mongo-10gen-server mongo-10gen }

default[:amp][:authdb][:host] = "iad-stg-auth101-v760.ihr"
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
default[:amp][:logging][:notify_list] = %w{ jeremybraff@clearchannel.com kengilmer@clearchannel.com LaurentVauthrin@clearchannel.com gregorypatmore@clearchannel.com }
