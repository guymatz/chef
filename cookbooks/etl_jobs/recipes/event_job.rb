directory "/data/jobs/event" do
  recursive true
end
directory "/data/log/event" do
  recursive true
end
directory "/data/log/event/input" do
  mode 0777
  recursive true
end
directory "/data/log/event/processed"
directory "/data/jobs/event/#{node.chef_environment}" do
  recursive true
end


remote_file "/data/jobs/event/event_job.jar" do
  source "http://files.ihrdev.com/jobs/event/#{node.chef_environment}/events_job-2.0.0.CI-SNAPSHOT.jar"
end
remote_file "/data/jobs/event/batch.properties.erb" do
  source "http://files.ihrdev.com/jobs/event/#{node.chef_environment}/batch.properties.erb"
end
remote_file "/data/jobs/event/log4j.properties.erb" do
  source "http://files.ihrdev.com/jobs/event/#{node.chef_environment}/log4j.properties.erb"
end

if /stage/ =~ node.chef_environment
  template "/data/jobs/event/batch.properties" do
    source "/data/jobs/event/batch.properties.erb"
    local true
  end
  template "/data/jobs/event/log4j.properties" do
    local true
    source "/data/jobs/event/log4j.properties.erb"
  end
end

cron_d "event_job" do
  command "/usr/bin/nsca_relay -S event-job -- /usr/bin/java -jar /data/jobs/event/event_job.jar launch-context.xml eventJob rundate=`/bin/date +\\%s`"
  minute 30
  hour 5
end
