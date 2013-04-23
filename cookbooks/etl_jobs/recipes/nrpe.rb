nagios_nrpecheck "check_app_proc_facebookconsumer" do
  command "#{node['nagios']['plugin_dir']}/check_procs -a '/home/amqp-consumer/facebook-consumer'"
  critical_condition "1:1"
end

nagios_nrpecheck "check_app_proc_playlogconsumer" do
  command "#{node['nagios']['plugin_dir']}/check_procs -a '/home/amqp-consumer/playlog-consumer'"
  critical_condition "1:1"
end

nagios_nrpecheck "check_playlog_exit_code" do
  command "#{node['nagios']['plugin_dir']}/check_exitcode.sh /var/log/playlog/exitCode"
end

nagios_nrpecheck "check_skiplog_exit_code" do
  command "#{node['nagios']['plugin_dir']}/check_exitcode.sh /var/log/skiplog/exitCode"
end

nagios_nrpecheck "check_sysinfo_exit_code" do
  command "#{node['nagios']['plugin_dir']}/check_exitcode.sh /var/log/sysinfo/exitCode"
end

nagios_nrpecheck "check_talkplaylog_exit_code" do
  command "#{node['nagios']['plugin_dir']}/check_exitcode.sh /var/log/talkplaylog/exitCode"
end

nagios_nrpecheck "check_talkthumbslog_exit_code" do
  command "#{node['nagios']['plugin_dir']}/check_exitcode.sh /var/log/talkthumbslog/exitCode"
end

nagios_nrpecheck "check_customthumbslog_exit_code" do
  command "#{node['nagios']['plugin_dir']}/check_exitcode.sh /var/log/customradiothumbslog/exitCode"
end

nagios_nrpecheck "check_livethumbslog_exit_code" do
  command "#{node['nagios']['plugin_dir']}/check_exitcode.sh /var/log/liveradiothumbslog/exitCode"
end
