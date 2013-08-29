# imgscaler nrpe checks

nagios_nrpecheck "check_app_proc_tomcat" do
  command "#{node['nagios']['plugin_dir']}/check_procs -a '-Djava.util.logging.config.file=/usr/local/tomcat7/conf/logging.properties -Xms512M -Xmx6G -XX:MaxPermSize=512m -XX:ThreadStackSize=256 -XX:+UseParallelGC -XX:+UseParallelOldGC -XX:+UseAdaptiveSizePolicy -Dnetworkaddress.cache.ttl=30 -Dnetworkaddress.cache.negative.ttl=1 -Duser.timezone=US/Eastern -XX:+PrintGCDetails -Xloggc:/usr/local/tomcat7/logs/gc.log -Dsun.net.client.defaultConnectTimeout=20000 -Dsun.net.client.defaultReadTimeout=20000 -Djava.util.logging.manager=org.apache.juli.ClassLoaderLogManager -server'"
  critical_condition "1:"
end
