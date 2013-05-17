#
# Cookbook Name:: etl_jobs
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute

include_recipe "users::amqp-consumer"

package "jdk"
package "freetds"

directory "/data"
directory "/data/jobs"
directory "/data/log"

directory "/data/jobs/event"
directory "/data/log/event"
directory "/data/log/event/input" do
  mode 0777
end
directory "/data/log/event/processed"
remote_file "/data/jobs/event/event_job.jar" do
  source "http://yum.ihr/files/jobs/event/event_job.jar"
end
remote_file "/data/jobs/event/batch.properties" do
  source "http://yum.ihr/files/jobs/event/batch.properties"
end
remote_file "/data/jobs/event/log4j.properties" do
  source "http://yum.ihr/files/jobs/event/log4j.properties"
end
cron_d "event_job" do
  command "/usr/bin/cronwrap use1b-jobserver101a event-job \"/usr/bin/java -jar /data/jobs/event/event_job.jar launch-context.xml eventJob rundate=`/bin/date +\\%s`\""
  minute 30
  hour 5
end

directory "/data/jobs/playlog"
directory "/data/log/playlog"
directory "/data/log/playlog/processed"
directory "/var/run/playlog"
remote_file "/data/jobs/playlog/playlog_wrapper.sh" do
  source "http://yum.ihr/files/jobs/playlog/playlog_wrapper.sh"
  mode 0755
end
remote_file "/data/jobs/playlog/playlog.jar" do
  source "http://yum.ihr/files/jobs/playlog/playlog_job.jar"
end
remote_file "/data/jobs/playlog/log4j.properties" do
  source "http://yum.ihr/files/jobs/playlog/log4j.properties"
end
remote_file "/data/jobs/playlog/batch.properties" do
  source "http://yum.ihr/files/jobs/playlog/batch.properties"
end
cron_d "playlog_job" do
  command "/usr/bin/cronwrap use1b-jobserver101a Playlog-ETL-Job \"/data/jobs/playlog/playlog_wrapper.sh\""
  minute 22
end

directory "/data/jobs/profile"
directory "/data/log/profile"
remote_file "/data/jobs/profile/profile_job.jar" do
  source "http://yum.ihr/files/jobs/profile/profile_job.jar"
end
#cron_d "profile_job" do
#  command "/usr/bin/cronwrap use1b-jobserver101a profile-job \"/usr/bin/java -jar /data/jobs/profile/profile_job.jar launch-context.xml profileJob rundate=`/bin/date +\\%s`\""
#  minute 30
#  hour 3
#end

directory "/data/jobs/live_thumbs"
directory "/data/log/liveradiothumbslog"
directory "/data/log/liveradiothumbslog/processed"
remote_file "/data/jobs/live_thumbs/live_thumbs_job.jar" do
  source "http://yum.ihr/files/jobs/live_thumbs/live_thumbs_job.jar"
end
cron_d "live_thumbs_job" do
  command "/usr/bin/cronwrap use1b-jobserver101a Liveradio-Thumb-ETL-Job \"/usr/bin/java -jar /data/jobs/live_thumbs/live_thumbs_job.jar launch-context.xml liveradiothumbslogJob rundate=`/bin/date +\\%s`\""
  minute 51
end

directory "/data/jobs/custom_thumbs"
directory "/data/log/customradiothumbslog"
directory "/data/log/customradiothumbslog/processed"
remote_file "/data/jobs/custom_thumbs/custom_thumbs_job.jar" do
  source "http://yum.ihr/files/jobs/custom_thumbs/custom_thumbs_job.jar"
end
cron_d "custom_thumbs_job" do
  command "/usr/bin/cronwrap use1b-jobserver101a Customradio-Thumb-ETL-Job \"/usr/bin/java -jar /data/jobs/custom_thumbs/custom_thumbs_job.jar launch-context.xml customradiothumbslogJob rundate=`/bin/date +\\%s`\""
  minute 38
end

directory "/data/jobs/talk_thumbs"
directory "/data/log/talkthumbslog"
directory "/data/log/talkthumbslog/processed"
remote_file "/data/jobs/talk_thumbs/talk_thumbs_job.jar" do
  source "http://yum.ihr/files/jobs/talk_thumbs/talk_thumbs_job.jar"
end
cron_d "talk_thumbs_job" do
  command "/usr/bin/cronwrap use1b-jobserver101a Talk-Thumb-Radio-ETL-Job \"/usr/bin/java -jar /data/jobs/talk_thumbs/talk_thumbs_job.jar launch-context.xml talkthumbslogJob rundate=`/bin/date +\\%s`\""
  minute 41
end

directory "/data/jobs/skiplog"
directory "/data/log/skiplog"
directory "/data/log/skiplog/processed"
remote_file "/data/jobs/skiplog/skiplog_job.jar" do
  source "http://yum.ihr/files/jobs/skiplog/skiplog_job.jar"
end
remote_file "/data/jobs/skiplog/log4j.properties" do
  source "http://yum.ihr/files/jobs/skiplog/log4j.properties"
end
remote_file "/data/jobs/skiplog/skipbatch.properties" do
  source "http://yum.ihr/files/jobs/skiplog/skipbatch.properties"
end
cron_d "skiplog_job" do
  command "/usr/bin/cronwrap use1b-jobserver101a Skiplog-ETL-Job \"/usr/bin/java -jar /data/jobs/skiplog/skiplog_job.jar launch-context.xml skiplogJob rundate=`/bin/date +\\%s`\""
  minute 17
end

directory "/data/jobs/talklog"
directory "/data/log/talkplaylog"
directory "/data/log/talkplaylog/processed"
remote_file "/data/jobs/talklog/talklog_job.jar" do
  source "http://yum.ihr/files/jobs/talklog/talklog_job.jar"
end
remote_file "/data/jobs/talklog/log4j.properties" do
  source "http://yum.ihr/files/jobs/talklog/log4j.properties"
end
remote_file "/data/jobs/talklog/skipbatch.properties" do
  source "http://yum.ihr/files/jobs/talklog/skipbatch.properties"
end
remote_file "/data/jobs/talklog/talkbatch.properties" do
  source "http://yum.ihr/files/jobs/talklog/talkbatch.properties"
end
cron_d "talklog_job" do
  command "/usr/bin/cronwrap use1b-jobserver101a Talklog-ETL-Job \"/usr/bin/java -jar /data/jobs/talklog/talklog_job.jar launch-context.xml talkJob rundate=`/bin/date +\\%s`\""
  minute 21
end

directory "/data/jobs/sysinfo"
directory "/data/log/sysinfo"
directory "/data/log/sysinfo/input" do
  mode 0777
end
directory "/data/log/sysinfo/processed"
remote_file "/data/jobs/sysinfo/sysinfo_job.jar" do
  source "http://yum.ihr/files/jobs/sysinfo/sysinfo_job.jar"
end
remote_file "/data/jobs/sysinfo/batch.properties" do
  source "http://yum.ihr/files/jobs/sysinfo/batch.properties"
end
remote_file "/data/jobs/sysinfo/log4j.properties" do
  source "http://yum.ihr/files/jobs/sysinfo/log4j.properties"
end
cron_d "sysinfo_job" do
  command "/usr/bin/cronwrap use1b-jobserver101a sysinfo-job \"/usr/bin/java -jar /data/jobs/sysinfo/sysinfo_job.jar launch-context.xml sysInfoJob rundate=`/bin/date +\\%s`\""
  minute 30
  hour 5
end

directory "/home/amqp-consumer/playlog-consumer" do
  owner "amqp-consumer"
  group "amqp-consumer"
end
directory "/data/log/playlog-consumer" do
  owner "amqp-consumer"
  group "amqp-consumer"
end
directory "/data/log/companion-consumer" do
  owner "amqp-consumer"
  group "amqp-consumer"
end
directory "/data/log/talk-playlog-consumer" do
  owner "amqp-consumer"
  group "amqp-consumer"
end
directory "/var/run/playlog-consumer" do
  owner "amqp-consumer"
  group "amqp-consumer"
end
remote_file "/home/amqp-consumer/playlog-consumer/playlog_consumer.jar" do
  source "http://yum.ihr/files/jobs/playlog-consumer/playlog_consumer.jar"
  owner "amqp-consumer"
  group "amqp-consumer"
end
remote_file "/home/amqp-consumer/playlog-consumer/env.properties" do
  source "http://yum.ihr/files/jobs/playlog-consumer/env.properties"
  owner "amqp-consumer"
  group "amqp-consumer"
end
remote_file "/home/amqp-consumer/playlog-consumer/log4j.xml" do
  source "http://yum.ihr/files/jobs/playlog-consumer/log4j.xml"
  owner "amqp-consumer"
  group "amqp-consumer"
end
remote_file "/etc/init.d/playlog-consumer" do
  source "http://yum.ihr/files/jobs/playlog-consumer/playlog.init"
  mode 0755
end

directory "/home/amqp-consumer/facebook-consumer" do
  owner "amqp-consumer"
  group "amqp-consumer"
end
directory "/data/log/facebook-consumer" do
  owner "amqp-consumer"
  group "amqp-consumer"
end
directory "/var/run/facebook-consumer" do
  owner "amqp-consumer"
  group "amqp-consumer"
end
remote_file "/home/amqp-consumer/facebook-consumer/facebook_consumer.jar" do
  source "http://yum.ihr/files/jobs/facebook-consumer/facebook_consumer.jar"
  owner "amqp-consumer"
  group "amqp-consumer"
end
remote_file "/home/amqp-consumer/facebook-consumer/env.properties" do
  source "http://yum.ihr/files/jobs/facebook-consumer/env.properties"
  owner "amqp-consumer"
  group "amqp-consumer"
end
remote_file "/home/amqp-consumer/facebook-consumer/log4j.xml" do
  source "http://yum.ihr/files/jobs/facebook-consumer/log4j.xml"
  owner "amqp-consumer"
  group "amqp-consumer"
end
remote_file "/etc/init.d/facebook-consumer" do
  source "http://yum.ihr/files/jobs/facebook-consumer/facebook.init"
  mode 0755
end

directory "/home/amqp-consumer/facebook-consumer-2" do
  owner "amqp-consumer"
  group "amqp-consumer"
end
directory "/data/log/facebook-consumer-2" do
  owner "amqp-consumer"
  group "amqp-consumer"
end
directory "/var/run/facebook-consumer-2" do
  owner "amqp-consumer"
  group "amqp-consumer"
end
remote_file "/home/amqp-consumer/facebook-consumer-2/facebook_consumer.jar" do
  source "http://yum.ihr/files/jobs/facebook-consumer-2/facebook_consumer.jar"
  owner "amqp-consumer"
  group "amqp-consumer"
end
remote_file "/home/amqp-consumer/facebook-consumer-2/env.properties" do
  source "http://yum.ihr/files/jobs/facebook-consumer-2/env.properties"
  owner "amqp-consumer"
  group "amqp-consumer"
end
remote_file "/home/amqp-consumer/facebook-consumer-2/log4j.xml" do
  source "http://yum.ihr/files/jobs/facebook-consumer-2/log4j.xml"
  owner "amqp-consumer"
  group "amqp-consumer"
end
remote_file "/etc/init.d/facebook-consumer-2" do
  source "http://yum.ihr/files/jobs/facebook-consumer-2/facebook.init"
  mode 0755
end

directory "/home/amqp-consumer/responsys-consumer" do
  owner "amqp-consumer"
  group "amqp-consumer"
end
directory "/data/log/responsys-consumer" do
  owner "amqp-consumer"
  group "amqp-consumer"
end
directory "/var/run/responsys-consumer" do
  owner "amqp-consumer"
  group "amqp-consumer"
end
remote_file "/home/amqp-consumer/responsys-consumer/responsys.tar.gz" do
  source "http://yum.ihr/files/jobs/responsys-consumer/responsys.tar.gz"
  action :create_if_missing
end
bash "extract-consumer" do
  cwd "/home/amqp-consumer/responsys-consumer"
  code "tar xpf responsys.tar.gz;chown -R amqp-consumer. *"
  not_if { File.exists?('/home/amqp-consumer/responsys-consumer/responsys_consumer.jar') }
end
remote_file "/etc/init.d/responsys-consumer" do
  source "http://yum.ihr/files/jobs/responsys-consumer/responsys.init"
  mode 0755
end

directory "/home/amqp-consumer/enrichment-consumer" do
  owner "amqp-consumer"
  group "amqp-consumer"
end
directory "/data/log/enrichment-consumer" do
  owner "amqp-consumer"
  group "amqp-consumer"
end
directory "/var/run/enrichment-consumer" do
  owner "amqp-consumer"
  group "amqp-consumer"
end
remote_file "/home/amqp-consumer/enrichment-consumer/enrichment.tar.gz" do
  source "http://yum.ihr/files/jobs/enrichment-consumer/enrichment.tar.gz"
  action :create_if_missing
end
bash "extract-enrichment-consumer" do
  cwd "/home/amqp-consumer/enrichment-consumer"
  code "tar xpf enrichment.tar.gz;chown -R amqp-consumer. *"
  not_if { File.exists?('/home/amqp-consumer/enrichment-consumer/enrichment_consumer.jar') }
end
remote_file "/etc/init.d/enrichment-consumer" do
  source "http://yum.ihr/files/jobs/enrichment-consumer/enrichment.init"
  mode 0755
end

cookbook_file "/data/jobs/log-archive.sh" do
  source "log-archive.sh"
  mode 0755
end
cron_d "archive_logs" do
  command "/usr/bin/cronwrap use1b-jobserver101a Archive-Logs \"/data/jobs/log-archive.sh 2>&1 >> /dev/null\""
  minute 15
end

#apis = search(:node, "role:amp AND chef_environment:#{node.chef_environment}")
#apis.each do |x|
#  ruby_block x.name do
#    block do
#      file = Chef::Util::FileEdit.new('/data/jobs/api_servers')
#      file.insert_line_if_no_match("/#{x.name}/m", "#{x.name}")
#      file.write_file
#    end
#  end
#end

cron_d "pull_event_logs" do
  command "/usr/bin/cronwrap use1b-jobserver101a Pull-Event-Logs \"for i in `/bin/cat /data/jobs/api_servers`; do /usr/bin/scp $i:/data/apps/tomcat7/logs/event.log.`/bin/date --date='1 day ago' +\%Y-\%m-\%d` /data/log/event/input/$i.event.log.`/bin/date --date='1 day ago' +\%Y-\%m-\%d`; done\""
  minute 27
  hour 1
  user 'ihr-deployer'
end
cron_d "pull_sysinfo_logs" do
  command "/usr/bin/cronwrap use1b-jobserver101a Pull-Sysinfo-Logs \"for i in `/bin/cat /data/jobs/api_servers`; do /usr/bin/scp $i:/data/apps/tomcat7/logs/sysinfo.log.`/bin/date --date='1 hour ago' +\%Y-\%m-\%d-\%H` /data/log/sysinfo/input/$i.sysinfo.log.`/bin/date --date='1 hour ago' +\%Y-\%m-\%d-\%H`; done\""
  minute '*/15'
  user 'ihr-deployer'
end

python_pip "pytz" do
  action :install
end
git "/data/jobs/radiomigration" do
  repository "git@github.com:iheartradio/radio-migration.git"
  reference "master"
end
directory "/data/log/radiomigration" do
  owner "ihr-deployer"
  group "ihr-deployer"
end
directory "/data/jobs/radiomigration/data" do
  owner "ihr-deployer"
  group "ihr-deployer"
end
bash "set-migration-perms" do
  code 'chown -R ihr-deployer. /data/jobs/radiomigration'
end
db_user = Chef::EncryptedDataBagItem.load("sqlserver", "users")
#cron_d "radiomigration" do
#  command "/usr/bin/cronwrap use1b-jobserver101a Radiomigration \"/data/jobs/radiomigration/ImportToDBFromCSV.sh localhost radio processed 10.10.182.175 appBatch #{db_user['appBatch']}\""
#  minute 50
#  hour 21
#  user 'ihr-deployer'
#end
