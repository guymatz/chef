#
# Cookbook Name:: flume-ng
# Attributes:: default
# Author:: pkatsev
#
# Copyright 2013, iHeartRadio
#
# All rights reserved - Do Not Redistribute
#
default[:flume_ng][:version] = "1.4.0-SNAPSHOT"
default[:flume_ng][:package] = "apache-flume-#{default[:flume_ng][:version]}-bin"
default[:flume_ng][:base_url] = "http://files.ihrdev.com/flume"
default[:flume_ng][:checksum] = "5f85b82c3c80"

default[:flume_ng][:base_path] = "/data/apps"
default[:flume_ng][:link] = "flume-ng"
default[:flume_ng][:home] = "#{default[:flume_ng][:base_path]}/#{default[:flume_ng][:link]}"
default[:flume_ng][:exec] = "#{default[:flume_ng][:home]}/bin/flume-ng"

default[:flume_ng][:user] = "flume"
default[:flume_ng][:group] = "flume"

default[:flume_ng][:log_dir] = "/var/log/flume-ng"
default[:flume_ng][:run_dir] = "/var/run/flume-ng"
default[:flume_ng][:log_file] = "flume.log"

default[:flume_ng][:conf_dir] = "conf"
default[:flume_ng][:conf_file] = "flume-conf.properties"
default[:flume_ng][:agent_name] = "agent1"

default[:flume_ng][:pidfile] = "#{default[:flume_ng][:agent_name]}.pid"
default[:flume_ng][:lockfile] = "/var/lock/subsys/flume-ng-#{default[:flume_ng][:agent_name]}"
default[:flume_ng][:niceness] = 0

default[:flume_ng][:hadoop][:namenode][:host] = "hadoop.ihrdev.com"
default[:flume_ng][:hadoop][:namenode][:avro_port] = "9999"
