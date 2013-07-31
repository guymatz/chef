
begin
  unless tagged?("ingestion-manager-deployed")

    template "#{node[:tomcat7][:install_path]}/bin/setenv.sh" do
          source "setenv.sh.erb"
          owner node[:tomcat7][:user]
          group node[:tomcat7][:group]
          mode "0755"
              variables({
                        })
    end

    template "#{node[:tomcat7][:install_path]}/bin/catalina.sh" do
          source "catalina.sh.erb"
          owner node[:tomcat7][:user]
          group node[:tomcat7][:group]
          mode "0755"
              variables({
                        })
    end

    package "jakarta-commons-daemon-jsvc" do
          action :install
    end


    node[:encoders][:filemonitor][:static_files].each do |dest,src|
        remote_directory dest do
            source src
            mode 0775
    end


#    execute "webapp_dir" do
#        command "mkdir -p #{node[:tomcat7][:install_path]}/webapps/"
#        not_if { ::File.exists?("#{node[:tomcat7][:install_path]}/webapps/ingester")} 
#    end

    cookbook_file "#{node[:tomcat7][:install_path]}/webapps/ingester.war" do
        source node[:encoders][:filemonitor][:ingester_war]
        mode 0555
        action :create_if_missing
    end

    cookbook_file "#{node[:tomcat7][:install_path]}/lib/postgresql-9.0-801.jdbc4.jar" do
        source node[:encoders][:filemonitor][:postgres_jar]
        mode 0644
        action :create_if_missing
    end

    directory "filemonitor_log" do
        owner "tomcat"
        group "tomcat"
        mode 0644
        action :create
        not_if { ::File.exists?(node[:encoders][:filemonitor][:logdir])} 
    end

    template "/etc/init.d/fileMonitorService" do
        source "fileMonitorService.erb"
        owner "root"
        mode "0755"
    end

    service "fileMonitorService" do
        action [:enable, :start]
    end

    file node[:encoder][:filemonitor][:monitor_script] do
          mode "775"
    end

    # Two processes here, since a java proc spawns a child with the same name
    nagios_nrpecheck "FileWatcher-jsvc" do
      command "#{node['nagios']['plugin_dir']}/check_procs"
      warning_condition "2:2"
      critical_condition "2:2"
      parameters '-C jsvc'
      action :add
    end

   tag("ingestion-manager-deployed")
   end
rescue
    untag("ingestion-manager-deployed")
end

