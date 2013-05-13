nagios_nrpecheck "check_app_proc_facebookconsumer" do
  command "#{node['nagios']['plugin_dir']}/check_procs -C java -a '/home/amqp-consumer/facebook-consumer'"
  critical_condition "2:2"
end

nagios_nrpecheck "check_app_proc_playlogconsumer" do
  command "#{node['nagios']['plugin_dir']}/check_procs -C java -a '/home/amqp-consumer/playlog-consumer'"
  critical_condition "1:1"
end

nagios_nrpecheck "check_app_proc_enrichmentconsumer" do
  command "#{node['nagios']['plugin_dir']}/check_procs -C java -a '/home/amqp-consumer/enrichment-consumer'"
  critical_condition "1:1"
end

nagios_nrpecheck "check_app_proc_responsysconsumer" do
  command "#{node['nagios']['plugin_dir']}/check_procs -C java -a '/home/amqp-consumer/responsys-consumer'"
  critical_condition "1:1"
end

nagios_nrpecheck "check_playlog_exit_code" do
  command "#{node['nagios']['plugin_dir']}/check_exitcode.sh /data/log/playlog/exitCode"
end

nagios_nrpecheck "check_skiplog_exit_code" do
  command "#{node['nagios']['plugin_dir']}/check_exitcode.sh /data/log/skiplog/exitCode"
end

nagios_nrpecheck "check_sysinfo_exit_code" do
  command "#{node['nagios']['plugin_dir']}/check_exitcode.sh /data/log/sysinfo/exitCode"
end

nagios_nrpecheck "check_talkplaylog_exit_code" do
  command "#{node['nagios']['plugin_dir']}/check_exitcode.sh /data/log/talkplaylog/exitCode"
end

nagios_nrpecheck "check_talkthumbslog_exit_code" do
  command "#{node['nagios']['plugin_dir']}/check_exitcode.sh /data/log/talkthumbslog/exitCode"
end

nagios_nrpecheck "check_customthumbslog_exit_code" do
  command "#{node['nagios']['plugin_dir']}/check_exitcode.sh /data/log/customradiothumbslog/exitCode"
end

nagios_nrpecheck "check_livethumbslog_exit_code" do
  command "#{node['nagios']['plugin_dir']}/check_exitcode.sh /data/log/liveradiothumbslog/exitCode"
end

nagios_nrpecheck "check_sysinfo_exit_code" do
  command "#{node['nagios']['plugin_dir']}/check_exitcode.sh /data/log/sysinfo/exitCode"
end

nagios_nrpecheck "check_event_exit_code" do
  command "#{node['nagios']['plugin_dir']}/check_exitcode.sh /data/log/event/exitCode"
end

nagios_nrpecheck "check_profile_exit_code" do
  command "#{node['nagios']['plugin_dir']}/check_exitcode.sh /data/log/profile/exitCode"
end

nagios_nrpecheck "check_radiomigration_exit_code" do
  command "#{node['nagios']['plugin_dir']}/check_exitcode.sh /data/jobs/radiomigration/exitCode"
end
