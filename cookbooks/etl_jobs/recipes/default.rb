#
# Cookbook Name:: etl_jobs
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute

package "jdk"

directory "/data"
directory "/data/jobs"

directory "/data/jobs/event"
directory "/var/log/event"
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
  command "cronwrap iad-jobserver101.ihr event-job \"java -jar /data/jobs/event/event_job.jar launch-context.xml eventJob rundate=`/bin/date +%s`\""
  minute 30
  hour 5
end

directory "/data/jobs/playlog"
directory "/var/log/playlog"
directory "/var/log/playlog/processed"
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
  command "cronwrap iad-jobserver101.ihr playlog-job \"java -jar /data/jobs/playlog/playlog.jar launch-context.xml playlogJob rundate=`/bin/date +%s`\""
  minute 22
end

directory "/data/jobs/profile"
directory "/var/log/profile"
remote_file "/data/jobs/profile/profile_job.jar" do
  source "http://yum.ihr/files/jobs/profile/profile_job.jar"
end
cron_d "profile_job" do
  command "cronwrap iad-jobserver101.ihr profile-job \"java -jar /data/jobs/profile/profile_job.jar launch-context.xml profileJob rundate="`/bin/date +%s`\""
  minute 30
  hour 3
end

directory "/data/jobs/live_thumbs"
directory "/var/log/liveradiothumbslog"
directory "/var/log/liveradiothumbslog/processed"
remote_file "/data/jobs/live_thumbs/live_thumbs_job.jar" do
  source "http://yum.ihr/files/jobs/live_thumbs/live_thumbs_job.jar"
end
cron_d "live_thumbs_job" do
  command "cronwrap iad-jobserver101.ihr live-thumb-job \"java -jar /data/jobs/live_thumbs/live_thumbs_job.jar launch-context.xml liveradiothumbslogJob rundate=`/bin/date +%s`\""
  minute 51
end

directory "/data/jobs/custom_thumbs"
directory "/var/log/customradiothumbslog"
directory "/var/log/customradiothumbslog/processed"
remote_file "/data/jobs/custom_thumbs/custom_thumbs_job.jar" do
  source "http://yum.ihr/files/jobs/custom_thumbs/custom_thumbs_job.jar"
end
cron_d "custom_thumbs_job" do
  command "cronwrap iad-jobserver101.ihr custom-thumb-job \"java -jar /data/jobs/custom_thumbs/custom_thumbs_job.jar launch-context.xml customradiothumbslogJob rundate=`/bin/date +%s`\""
  minute 38
end

directory "/data/jobs/talk_thumbs"
directory "/var/log/talkthumbslog"
directory "/var/log/talkthumbslog/processed"
remote_file "/data/jobs/talk_thumbs/talk_thumbs_job.jar" do
  source "http://yum.ihr/files/jobs/talk_thumbs/talk_thumbs_job.jar"
end
cron_d "talk_thumbs_job" do
  command "cronwrap iad-jobserver101.ihr talk-thumb-job \"java -jar /data/jobs/talk_thumbs/talk_thumbs_job.jar launch-context.xml talkthumbslogJob rundate=`/bin/date +%s`\""
  minute 41
end

directory "/data/jobs/skiplog"
directory "/var/log/skiplog"
directory "/var/log/skiplog/processed"
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
  command "cronwrap iad-jobserver101.ihr skiplog-job \"java -jar /data/jobs/skiplog/skiplog_job.jar launch-context.xml skiplogJob rundate=`/bin/date +%s`\""
  minute 17
end

directory "/data/jobs/talklog"
directory "/var/log/talkplaylog"
directory "/var/log/talkplaylog/processed"
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
  command "cronwrap iad-jobserver101.ihr talklog-job \"java -jar /data/jobs/talklog/talklog_job.jar launch-context.xml talkJob rundate=`/bin/date +%s`\""
  minute 21
end

directory "/data/jobs/sysinfo"
directory "/var/log/sysinfo"
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
  command "cronwrap iad-jobserver101.ihr sysinfo-job \"java -jar /data/jobs/sysinfo/sysinfo_job.jar launch-context.xml sysInfoJob rundate=`/bin/date +%s`\""
  minute 30
  hour 5
end

user "amqp-consumer"
directory "/home/amqp-consumer/playlog-consumer" do
  owner "amqp-consumer"
  group "amqp-consumer"
end
directory "/var/log/playlog-consumer" do
  owner "amqp-consumer"
  group "amqp-consumer"
end
directory "/var/log/companion-consumer" do
  owner "amqp-consumer"
  group "amqp-consumer"
end
directory "/var/log/talk-playlog-consumer" do
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
directory "/var/log/facebook-consumer" do
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

#directory "/usr/local/radiomigrations"
#%w{ FileProcess_Live.py FileProcess.py FileProcessTalk.py ImportToDBFromCSV.sh RenameTables_Live.py RenameTables.py TruncateData.py }.each do |file|
#  remote_file "/usr/local/radiomigrations/#{file}" do
#    source "radiomigrations/#{file}"
#  end
#end
#db_creds = Chef::EncryptedDataBagItem.load("mssqlserver", "radiomigration")
#cron_d "radiomigration" do
#  command "cronwrap iad-jobserver101.ihr \"/usr/local/radiomigrations/ImportToDBFromCSV.sh 10.90.40.5 radio processed 10.10.182.175 #{db_creds['user']} #{db_creds['pass']}\""
#  minute 50
#  hour 21
#end
