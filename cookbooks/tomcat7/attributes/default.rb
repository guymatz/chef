#
# Cookbook Name:: tomcat7
# Attributes:: default
#
# Copyright 2013, Jake Plimack <jake.plimack@gmail.com>
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

default[:tomcat7][:user] = "tomcat"
default[:tomcat7][:group] = "tomcat"
default[:tomcat7][:version] = "7.0.39"
#http://mirrors.ibiblio.org/apache/tomcat/tomcat-7/v7.0.39/bin/apache-tomcat-7.0.39.tar.gz
default[:tomcat7][:url] = "http://archive.apache.org/dist/tomcat/tomcat-7"
default[:tomcat7][:install_path] = "/data/apps/tomcat7"

default[:tomcat7][:port] = 8080
default[:tomcat7][:ssl_port] = 8443
default[:tomcat7][:ajp_port] = 8009
default[:tomcat7][:java_options] = "-Xmx128M -Djava.awt.headless=true"
default[:tomcat7][:use_security_manager] = false
default[:tomcat7][:authbind] = "no"
