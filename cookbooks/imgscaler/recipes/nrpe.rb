# imgscaler nrpe checks

nagios_nrpecheck "check_app_proc_tomcat" do
  command "#{node['nagios']['plugin_dir']}/check_procs -a '-Djava.util.logging.config.file=/usr/local/tomcat7/conf/logging.properties -Xms512M -Xmx6G -XX:MaxPermSize=512m -XX:ThreadStackSize=256 -XX:+UseParallelGC -XX:+UseParallelOldGC -XX:+UseAdaptiveSizePolicy -Dnetworkaddress.cache.ttl=30 -Dnetworkaddress.cache.negative.ttl=1 -Duser.timezone=US/Eastern -XX:+PrintGCDetails -Xloggc:/usr/local/tomcat7/logs/gc.log -Dsun.net.client.defaultConnectTimeout=20000 -Dsun.net.client.defaultReadTimeout=20000 -Djava.util.logging.manager=org.apache.juli.ClassLoaderLogManager -server -Djava.rmi.server.hostname= -Dcom.sun.management.jmxremote.port=8999 -Dcom.sun.management.jmxremote.ssl=false -Dcom.sun.management.jmxremote.authenticate=false -Djava.endorsed.dirs=/usr/local/tomcat7/endorsed -classpath /usr/local/tomcat7/bin/bootstrap.jar:/usr/local/tomcat7/bin/tomcat-juli.jar -Dcatalina.base=/usr/local/tomcat7 -Dcatalina.home=/usr/local/tomcat7 -Djava.io.tmpdir=/usr/local/tomcat7/temp org.apache.catalina.startup.Bootstrap'"
  critical_condition "1:1"
end
