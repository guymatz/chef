nagios_nrpecheck "Radioedit-Proc-Check" do
  command "#{node['nagios']['plugin_dir']}/check_procs"
  warning_condition "1:5"
  critical_condition "0:0"
  parameters "-C gunicorn"
  action :add
end
