
default[:amp][:version] = "2.16.1"
default[:amp][:url] = "http://yum.ihr/files/amp"

default[:amp][:packages] = %w{ mongo-10gen-server mongo-10gen }

default[:amp][:authdb][:host] = "iad-auth101-v260.ihr"
default[:amp][:pgbouncer][:port] = "5432"
