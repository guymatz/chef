nagios_nrpecheck "check_app_proc_tomcat" do
  command "#{node['nagios']['plugin_dir']}/check_procs -a '-Djava.util.logging.config.file=/data/apps/tomcat7/conf/logging.properties -Djava.util.logging.manager=org.apache.juli.ClassLoaderLogManager -Xms512M -Xmx1G -XX:MaxPermSize=512m -XX:ThreadStackSize=256 -XX:+UseParallelGC -XX:+UseParallelOldGC -XX:+UseAdaptiveSizePolicy -Dnetworkaddress.cache.ttl=30 -Dnetworkaddress.cache.negative.ttl=1 -Duser.timezone=US/Eastern -XX:+PrintGCDetails -Xloggc:/data/apps/tomcat7/logs/gc.log -Dsun.net.client.defaultConnectTimeout=20000 -Dsun.net.client.defaultReadTimeout=20000 -server'"
  critical_condition "1:1"
end
