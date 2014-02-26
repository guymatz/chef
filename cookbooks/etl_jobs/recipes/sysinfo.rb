directory "/data/jobs/sysinfo"
directory "/data/log/sysinfo"
directory "/data/log/sysinfo/input" do
  mode 0777
end
directory "/data/log/sysinfo/processed"
remote_file "/data/jobs/sysinfo/sysinfo_job.jar" do
  source "http://files.ihrdev.com/jobs/sysinfo/#{node[:sysinfo][:version]}/sysinfo_job.jar"
  action :create_if_missing
end
remote_file "/data/jobs/sysinfo/batch.properties" do
  source "http://files.ihrdev.com/jobs/sysinfo/#{node[:sysinfo][:version]}/batch.properties"
  action :create_if_missing
end
remote_file "/data/jobs/sysinfo/log4j.properties" do
  source "http://files.ihrdev.com/jobs/sysinfo/#{node[:sysinfo][:version]}/log4j.properties"
  action :create_if_missing
end

template "/home/ihr-deployer/sysinfo.sh" do
  source "sysinfo.sh.erb"
  mode "0755"
  owner "ihr-deployer"
  group "ihr-deployer"
end

cron_d "sysinfo_job" do
  command "/usr/bin/java -cp \"/data/jobs/sysinfo/sysinfo_job.jar:/data/jobs/sysinfo/\" org.springframework.batch.core.launch.support.CommandLineJobRunner launch-context.xml sysInfoJob rundate=`/bin/date +\\%s`"
  minute 30
  hour 6
end

cron_d "pull_sysinfo_logs" do
  command "/usr/bin/nsca_relay -S Pull-Sysinfo-Logs -- /home/ihr-deployer/sysinfo.sh"
  minute '*/15'
  user 'ihr-deployer'
end
