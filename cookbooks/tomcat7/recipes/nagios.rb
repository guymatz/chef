#
# tomcat7::nagios
#
# written by Jake Plimack <jake.plimack@gmail.com>
#


nagios_nrpecheck "Tomcat_Process" do
  command "#{node['nagios']['plugin_dir']}/check_procs"
  warning_condition "1:1"
  critical_condition "1:1"
  parameters "-C java -a '-Djava.util.logging.config.file=/data/apps/tomcat7/conf/logging.properties -Djava.util.logging.manager=org.apache.juli.ClassLoaderLogManager -Xms512M -Xmx7G -XX:MaxPermSize=512m -XX:ThreadStackSize=256 -XX:+UseParallelGC -XX:+UseParallelOldGC -XX:+UseAdaptiveSizePolicy -Dnetworkaddress.cache.ttl=30 -Dnetworkaddress.cache.negative.ttl=1 -Duser.timezone=US/Eastern -XX:+PrintGCDetails -Xloggc:/data/apps/tomcat7/logs/gc.log -Dsun.net.client.defaultConnectTimeout=20000 -Dsun.net.client.defaultReadTimeout=20000 -server'"
  action :add
  notifies :restart, "service[nagios-nrpe-server]"
end
